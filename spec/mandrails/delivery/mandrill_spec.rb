require 'spec_helper'
require 'action_mailer'
require 'mandrails/delivery/mandrill'

describe Mandrails::Delivery::Mandrill do
  subject { described_class.new(key: "12345") }

  class SimpleMailer < ::ActionMailer::Base
    default from: "frank@at-point.ch"
    def sample_email
      mail(to: "megan@at-point.ch", subject: "Hell Yeah", body: "Yo bro!")
    end
  end

  let(:messages) {
    double("messages").tap { |msg| subject.mandrill_api.stub(:messages) { msg } }
  }
  let(:sample_email) { SimpleMailer.sample_email }

  context ':key' do
    it 'raises an exception if missing' do
      handler = described_class.new(key: nil)
      expect { handler.deliver!(sample_email) }.to raise_error ::Mandrill::Error, /Mandrill API key/
    end

    it "is forwarded to mandrill gem as key when creating API instance" do
      subject.mandrill_api.apikey.should == "12345"
    end
  end

  context "#deliver!" do
    it "uses mandrill API" do
      messages.should_receive(:send) { [{"email" => "megan@at-point.ch", "status" => "sent"}] }
      subject.deliver!(sample_email).should == subject
    end
  end
end
