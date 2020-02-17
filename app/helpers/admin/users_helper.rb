module Admin
  module UsersHelper
    def last_signed_time_for(user)
      if user.last_sign_in_at
        "#{I18n.l(user.last_sign_in_at)}"
      end
    end

    def time_since_last_login_for(user)
      if user.last_sign_in_at
        "(#{time_ago_in_words(user.last_sign_in_at)} ago)"
      end
    end
  end
end

