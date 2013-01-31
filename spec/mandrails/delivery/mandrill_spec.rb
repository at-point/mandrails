require 'spec_helper'
require 'action_mailer'
require 'mandrails/delivery/mandrill'

describe Mandrails::Delivery::Mandrill do
  subject { described_class.new(key: "12345") }

  class SimpleMailer < ::ActionMailer::Base
    default from: "frank@at-point.ch", from_name: "Frank S."
    def sample_email
      mail(to: "megan@at-point.ch", subject: "Hell Yeah") do |fmt|
        fmt.html { render text: "<b>Yo bro!</b>" }
        fmt.text { render text: "Yo bro!" }
      end
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
    it "is able to handle :from_name" do
      messages.should_receive(:send) do |msg, async|
        msg[:from_name].should == "Frank S."
      end
      subject.deliver!(sample_email)
    end

    it "sets :html" do
      messages.should_receive(:send) do |msg, async|
        msg[:html].should eql "<b>Yo bro!</b>"
      end
      subject.deliver!(sample_email)
    end

    it "sets :text" do
      messages.should_receive(:send) do |msg, async|
        msg[:text].should eql "Yo bro!"
      end
      subject.deliver!(sample_email)
    end
  end
end
