class IpBanSettingsSet < ApplicationRecord
  belongs_to :organization

  validates_presence_of :ban_duration
  validates_presence_of :number_of_permitted_failed_requests
  validates_presence_of :check_duration
  validates_presence_of :number_of_emails_within_check
end
