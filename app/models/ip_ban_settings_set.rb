class IpBanSettingsSet < ApplicationRecord
  belongs_to :organization

  validates_presence_of :ban_duration
  validates_presence_of :number_of_permitted_failed_requests
  validates_presence_of :check_duration
  validates_presence_of :number_of_emails_within_check

  def settings_hash
    {
      ban_duration: ban_duration,
      number_of_permitted_failed_requests: number_of_permitted_failed_requests,
      check_duration: check_duration,
      number_of_emails_within_check: number_of_emails_within_check,
    }
  end
end
