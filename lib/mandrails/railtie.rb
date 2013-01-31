require 'rails'

module Mandrails
  class Railtie < Rails::Railtie #:nodoc:
    initializer 'mandrails.setup_action_mailer', before: 'action_mailer.set_configs' do
      ActiveSupport.on_load(:action_mailer) do
        add_delivery_method :mandrails, Mandrails::Delivery::Mandrill
      end
    end
  end
end
