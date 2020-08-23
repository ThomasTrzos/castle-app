require 'rails_helper'

RSpec.describe(IpBanSettingsSet, type: :model) do
  subject do
    described_class.new(
      organization_id: FactoryBot.create(:organization).id,
      ban_duration: 30,
      number_of_permitted_failed_requests: 5,
      check_duration: 60,
      number_of_emails_within_check: 10,
    )
  end

  it { should belong_to(:organization) }

  it 'is valid with valid attributes' do
    expect(subject).to(be_valid)
  end

  it 'is not valid without a ban_duration' do
    subject.ban_duration = nil
    expect(subject).to_not(be_valid)
  end

  it 'is not valid without a number_of_permitted_failed_requests' do
    subject.number_of_permitted_failed_requests = nil
    expect(subject).to_not(be_valid)
  end

  it 'is not valid without a check_duration' do
    subject.check_duration = nil
    expect(subject).to_not(be_valid)
  end

  it 'is not valid without a number_of_emails_within_check' do
    subject.number_of_emails_within_check = nil
    expect(subject).to_not(be_valid)
  end

  describe('#settings_hash') do
    it 'returns correct hash' do
      expect(subject.settings_hash).to(include(
        :ban_duration,
        :number_of_permitted_failed_requests,
        :check_duration,
        :number_of_emails_within_check
      ))
    end
  end
end
