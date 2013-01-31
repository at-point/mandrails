require 'spec_helper'
require 'mail'
require 'mandrails/message_builder'

describe Mandrails::MessageBuilder do
  include MailsSupport

  subject { described_class.new(text_mail).as_json }

  context 'subject' do
    it 'sets :subject' do
      subject[:subject].should == 'Hi'
    end
  end

  context 'recipients' do
    it 'sets :to Array' do
      subject[:to].should == [{ email: "megan@fox.com", name: "megan@fox.com" }]
    end

    context 'To, Cc & Bcc' do
      subject { described_class.new(cc_mail).as_json }

      it 'sets :to by combining To & Cc' do
        subject[:to].should == [{ email: "megan@fox.com", name: "megan@fox.com" }, { email: "mila@fox.com", name: "mila@fox.com" }]
      end
    end
  end

  context 'from' do
    it 'sets :from_email and :from_name' do
      subject[:from_email].should == 'mila@fox.com'
      subject[:from_name].should be_nil
    end

    it 'sets :from_name based on header' do
      text_mail[:from_name] = 'Mila'
      subject[:from_name].should == 'Mila'
    end

    context 'with default from_name & from_email' do
      subject { described_class.new(text_mail, from_name: "App", from_mail: "app@fox.com").as_json }

      it 'sets :from_name from default' do
        subject[:from_name].should == 'App'
      end
    end
  end

  context 'body' do
    context 'text only mail' do
      subject { described_class.new(text_mail).as_json }

      it 'sets :html key to nil' do
        subject[:html].should be_nil
      end

      it 'sets :text' do
        subject[:text].should == 'Yoo buddy'
      end
    end

    context 'html only mail' do
      subject { described_class.new(html_mail).as_json }

      it 'sets :html' do
        subject[:html].should == '<b>Yoo</b> buddy'
      end

      it 'sets :text to nil' do
        subject[:text].should be_nil
      end
    end

    context 'multipart mail' do
      subject { described_class.new(multipart_mail).as_json }

      it 'sets :html' do
        subject[:html].should == '<b>Yoo</b> buddy'
      end

      it 'sets :text' do
        subject[:text].should == 'Yoo buddy'
      end
    end
  end
end
