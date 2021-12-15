class InvitationWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'communication'

  def perform(id)
    user = User.find(id)
    UserNotifierMailer.send_signup_email(user).deliver! unless user.blank?
  end
end
