
organization = Organization.create(
  name: 'CastleIo'
)

IpBanSettingsSet.create(
  organization_id: organization.id,
  ban_duration: 10,
  number_of_permitted_failed_requests: 5,
  check_duration: 10,
  number_of_emails_within_check: 5,
)