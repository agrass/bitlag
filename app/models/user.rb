class User < ActiveRecord::Base
  before_create :set_api_key
  has_many :users_events
  has_many :events, :through => :users_events
  
  private
  def set_api_key
    self.api_key = SecureRandom.urlsafe_base64
  end
end
