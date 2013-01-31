require 'rails'
require 'action_mailer'

module Mandrails
  class Railtie < Rails::Railtie #:nodoc:
    initializer 'mandrails.setup_action_mailer' do
      require 'mandrails/action_mailer'
    end
  end
end
