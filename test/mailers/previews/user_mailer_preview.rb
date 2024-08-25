class UserMailerPreview < ActionMailer::Preview
    def reset_password_email
        user = Admin.first
        Devise::Mailer.reset_password_instructions(user, user.reset_password_token)
    end
  end
  