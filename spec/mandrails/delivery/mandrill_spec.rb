require 'spec_helper'
require 'mandrails/delivery/mandrill'

describe Mandrails::Delivery::Mandrill do
  include MailsSupport

  subject { described_class.new(key: "12345") }

  let(:messages) {
    double("messages").tap { |msg| subject.mandrill_api.stub(:messages) { msg } }
  }

  context ':key' do
    it 'raises an exception if missing' do
      handler = described_class.new(key: nil)
      expect { handler.deliver!(text_mail) }.to raise_error ::Mandrill::Error, /Mandrill API key/
    end

    it 'is forwarded to mandrill gem as key when creating API instance' do
      subject.mandrill_api.apikey.should == "12345"
    end
  end

  context '#deliver!' do
    it 'delegates message to mandrill gem' do
      messages.should_receive(:send).with(kind_of(Hash), false) { "OK" }
      subject.deliver! text_mail
    end

    context 'async' do
      it 'normally does not send async' do
        messages.should_receive(:send).with(kind_of(Hash), false) { "OK" }
        subject.deliver! text_mail
      end

      context 'when :async is true' do
        subject { described_class.new(key: '12345', async: true) }

        it 'defaults to sending async' do
        messages.should_receive(:send).with(kind_of(Hash), true) { "OK" }
        subject.deliver! text_mail
        end
      end
    end

    context 'return value' do
      it 'normally returns self' do
        messages.should_receive(:send) { "OK" }
        subject.deliver!(text_mail).should eql subject
      end

      context 'when :return_response is true' do
        subject { described_class.new(key: '12345', return_response: true) }

        it 'returns the response 1:1 as returned by the mandrill gem' do
          messages.should_receive(:send) { "TEH result" }
          subject.deliver!(text_mail).should == "TEH result"
        end
      end
    end
  end
end
