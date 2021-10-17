module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_end_user

    def connect
      self.current_end_user = find_verified_end_user
    end

    protected

    def find_verified_end_user
      verified_end_user = EndUser.find_by(id: env['warden'].user.id)
      return reject_unauthorized_connection unless verified_end_user
      verified_end_user
    end
  end
end
