class SignUpSubscriber < ActiveSupport::Subscriber

  attach_to :sign_up_services

  def person_signed_up(msg)
    user_id = msg.payload[:user_id]
    UserMailer.register_complete(user_id).deliver_later
  end
end
