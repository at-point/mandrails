require "mail"
require "mandrill"

require "mandrails/message_builder"

module Mandrails
  module Delivery

    # == Sending e-mail with Mandrill API
    #
    # A delivery method implementation which uses the Mandrill REST API.
    # This is done by providing a mailer on top of mandrill-api gem.
    #
    # === Using it with mail gem
    #
    # Requires the <code>:key</code> option, or set the environment
    # variable <code>MANDRILL_APIKEY</code> to a your Mandrill API key.
    #
    #   Mail.defaults do
    #     delivery_method Mandrails::Delivery::Mandrill, {
    #                              :key        => "123...-abcde", # or set the MANDRILL_APIKEY environment variable
    #                              :from_name  => "Your Name",
    #                              :from_email => "your@mail.com" }
    #   end
    #
    # === Using it with Rails & ActionMailer
    #
    # Using the railtie the <code>:mandrill</code> delivery method is
    # automatically available, also ensure to set the API key using
    # either <code>:key</code> setting or <code>MANDRILL_APIKEY</code>
    # environment variable. Add something like to the <code>config/environments/*</code>:
    #
    #    config.action_mailer.delivery_method = :mandrill
    #    config.action_mailer.mandrails_settings = {
    #      key: "123...-abcde", # or set the MANDRILL_APIKEY environment variable
    #      from_name: "Your Name",
    #      from_email: "your@mail.com" }
    #
    class Mandrill

      # Provide read/write access, dunno why write access is required,
      # but seems to be in all deliver_methods from mikel/mail as well
      attr_accessor :settings

      def initialize(values = nil) #:nodoc:
        @settings = {
                      track_opens: true,
                      track_clicks: false,
                      auto_text: true,
                      merge: false,
                      async: false,
                      key: ::ENV['MANDRILL_APIKEY'].presence
                    }.merge(values || {})
      end

      # Public: Access to the Mandrill::API instance used to send messages. It raises an
      # error if no key was given or is present.
      #
      # Returns Mandrill::API instance.
      def mandrill_api
        @mandrill_api ||= ::Mandrill::API.new(settings[:key].presence)
      end

      def deliver!(mail)
        # TODO: verify incoming `mail` argument, see https://github.com/mikel/mail/blob/master/lib/mail/check_delivery_params.rb
        builder = Mandrails::MessageBuilder.new mail, settings
        response = mandrill_api.messages.send(builder.as_json, settings[:async])

        # Either return response or instance
        return response if settings[:return_response]
        self
      end
    end
  end
end
