class CreateIpBanSettingsSets < ActiveRecord::Migration[6.0]
  def change
    create_table :ip_ban_settings_sets do |t|
      t.integer :ban_duration
      t.integer :number_of_permitted_failed_requests
      t.integer :check_duration
      t.integer :number_of_emails_within_check
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
