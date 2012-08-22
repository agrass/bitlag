class User < ActiveRecord::Base
  before_create :set_api_key

  private
  def set_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end
