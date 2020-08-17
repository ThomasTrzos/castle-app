class Organization < ApplicationRecord
  validates_presence_of :name

  before_create :set_api_token

  private

  def set_api_token
    self.api_token ||= SecureRandom.uuid
  end
end
