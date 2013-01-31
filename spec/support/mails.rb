require 'mail'

module MailsSupport

  def text_mail
    @text_mail ||= Mail.new do
      from 'mila@fox.com'
      to 'megan@fox.com'
      subject 'Hi'
      body 'Yoo buddy'
    end
  end

  def html_mail
    @html_mail ||= Mail.new do
      to 'megan@fox.com'
      content_type 'text/html'
      body '<b>Yoo</b> buddy'
    end
  end

  def multipart_mail
    @multipart_mail ||= Mail.new do
      to 'megan@fox.com'
      text_part { body 'Yoo buddy' }
      html_part { body '<b>Yoo</b> buddy' }
    end
  end

  def cc_mail
    @cc_mail ||= begin
      text_mail[:to] = 'Megan <megan@fox.com>'
      text_mail[:cc] = 'Mila <mila@fox.com>'
      text_mail[:bcc] = 'Emma <emma@fox.com>'
      text_mail
    end
  end
end
