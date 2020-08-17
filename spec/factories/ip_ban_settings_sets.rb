FactoryBot.define do
  factory :ip_ban_settings_set do
    ban_duration { [10, 20, 60].sample }
    number_of_permitted_failed_requests { [5, 10, 20].sample }
    check_duration { [10, 30, 60].sample }
    number_of_emails_within_check { [5, 10, 15].sample }
  end
end
