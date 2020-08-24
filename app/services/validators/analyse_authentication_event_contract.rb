class Validators::AnalyseAuthenticationEventContract < Dry::Validation::Contract
  params do
    required(:event_name).filled(eql?: 'login_failed')
    required(:ip_address).value(:string).filled
    required(:email).value(:string).filled
  end
end
