require 'spec_helper'
require 'action_mailer'
require 'mandrails/delivery/mandrill'

describe Mandrails::Delivery::Mandrill do
  subject { described_class.new(key: '12345') }

  class SimpleMailer < ::ActionMailer::Base
    default from: "mandrill@example.com"
    def welcome_email
      mail(to: "lukas@at-point.ch", subject: "Hell Yeah", body: "Yo bro!")
    end
  end

  context 'api key' do
    subject { described_class.new(key: nil) }
    it 'raises an exception if missing' do

    end
  end

  context "#deliver!" do
    it "uses mandrill REST API" do
      email = SimpleMailer.welcome_email
      p subject.deliver!(email)
    end
  end
end
