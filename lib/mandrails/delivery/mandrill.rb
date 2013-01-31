require "mail"
require "mandrill"

module Mandrails
  module Delivery

    # A delivery method implementation which uses the Mandrill REST API.
    #
    #
    class Mandrill

      # Provide read/write access, dunno why write access is required,
      # but seems to be in all deliver_methods from mikel/mail as well
      attr_accessor :settings

      def initialize(values = nil)
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
        message = build_message(mail)
        response = mandrill_api.messages.send(message, settings[:async])

        # Either return response or instance
        return response if settings[:return_response]
        self
      end

      private

      def build_message(mail)
        message = {}
        [:track_opens, :track_clicks, :auto_text, :url_strip_qs, :preserve_recipients, :bcc_address, :merge].each do |key|
          message[key] = settings[key] if settings.has_key?(key)
        end

        message[:subject] = mail.subject
        message[:from_name] = mail.header['from-name'].to_s.presence || settings[:from_name]
        message[:from_email] = mail.from && mail.from.first.presence || settings[:from_email]
        message[:to] = mail.to.map { |email| { email: email, name: email } }
        message[:headers] = { 'Reply-To' => mail.reply_to.presence }

        message[:tags] = Array.wrap(settings[:tags]) if settings[:tags].present?

        [:html, :text].each do |format|
          content = mail.send("#{format}_part")
          message[format] = content.body.raw_source if content.present?
        end

        message
      end
    end
  end
end
