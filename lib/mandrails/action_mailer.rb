require "action_mailer"
require "mandrails/delivery/mandrill"

ActiveSupport.on_load(:action_mailer) do
  ActionMailer::Base.add_delivery_method(:mandrails, Mandrails::Delivery::Mandrill)
end
