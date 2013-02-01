require 'active_support/core_ext/object'

module Mandrails

  # The MessageBuilder is used to convert a Mail::Message into a JSON object
  # consumable by the Mandrill API.
  class MessageBuilder

    # Setting keys which are not allowed to by set by the message
    RESTRICTED_KEYS = %w{key async}

    # Known mandrill settings
    MANDRILL_SETTINGS = [:track_opens, :track_clicks, :auto_text,
      :url_strip_qs, :preserve_recipients, :bcc_address]

    # Access to mail and defaults
    attr_reader :mail, :defaults

    # Public:
    #
    def initialize(mail, defaults = {})
      @mail = mail
      @defaults = defaults.reject { |key, value| RESTRICTED_KEYS.include?(key.to_s) }
    end

    def message
      @message ||= defaults.merge(
        # E-Mail stuff
        html: body(:html),
        text: body(:text),
        subject: mail.subject,
        from_email: from_email,
        from_name: from_name,
        to: recipients,

        # Additional headers
        headers: headers)
    end

    # Internal: Extract from name from either the header or defaults.
    #
    # Returns String.
    def from_name
      mail.header['from-name'].to_s.presence || defaults[:from_name]
    end

    # Internal: Extract from email.
    #
    # Returns String
    def from_email
      mail.from && mail.from.first.presence || defaults[:from_email]
    end

    # Internal: Extract body of specified format, if any.
    #
    # Returns String or nil.
    def body(format)
      content = mail.send("#{format}_part").presence
      content ||= mail if mail.mime_type =~ %r{\Atext/#{format}} || format == :text && text?
      content.body.raw_source if content.present?
    end

    def text?
      mail.mime_type =~ %r{\Atext/plain} || !mail.mime_type
    end

    # Internal: Build recipients list.
    #
    # Returns Array of Hash with `:name`, `:email`.
    def recipients
      [mail.to, mail.cc].compact.flatten.map { |email| { email: email, name: email } }
    end

    # Internal: Extract Reply-To header field.
    # TODO: extract all X-* headers as well!
    #
    # Returns Hash.
    def headers
      headers = {}
      headers['Reply-To'] = mail.reply_to.to_s if mail.reply_to.present?
      headers
    end

    def as_json
      message
    end
  end
end
