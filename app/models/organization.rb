class Organization < ApplicationRecord
  has_one :ip_ban_settings_set
  
  validates_presence_of :name

  before_create :set_api_token

  private

  def set_api_token
    self.api_token ||= SecureRandom.uuid
  end
end
