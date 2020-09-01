# frozen_string_literal: true

class Api::V1::AuthenticationEventsController < ApplicationController
  def analyse
    if organization.present?
      if valid_params?
        settings_hash = Rails.cache.fetch("analyse_endpoint/#{authentication_event_params[:api_token]}", expires_in: 10.minutes) do
          organization.ip_ban_settings_set.settings_hash
        end

        result = AnalyseAuthenticationEvent.call(authentication_event_params.merge(settings_hash))

        if result == true
          render(json: { message: 'Next login request permitted.' }, status: :ok)
        else
          render(json: { message: "User hits login limitations. Ip address banned for #{settings_hash[:ban_duration]} seconds." }, status: :ok)
        end

      else
        render(json: @contract_result.errors.to_h, status: :unprocessable_entity)
      end

    else
      render(json: { error: 'Invalid ApiToken' }, status: :unauthorized)
    end
  end

  private

  def authentication_event_params
    params.permit(
      :api_token,
      :event_name,
      :ip_address,
      :email
    )
  end

  def valid_params?
    contract = Validators::AnalyseAuthenticationEventContract.new
    @contract_result = contract.call(
      event_name: authentication_event_params[:event_name],
      ip_address: authentication_event_params[:ip_address],
      email: authentication_event_params[:email]
    )
    @contract_result.errors.empty?
  end

  def organization
    @organization ||= Organization.find_by(api_token: authentication_event_params[:api_token])
  end
end
