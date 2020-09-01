# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::AuthenticationEventsController, type: :request do
  describe 'GET /analyse' do
    subject { get('/api/v1/authentication_events/analyse', params: params) }

    let!(:organization) { FactoryBot.create(:organization) }
    let!(:ip_ban_settings_set) { FactoryBot.create(:ip_ban_settings_set, organization_id: organization.id) }
    let!(:api_token) { organization.api_token }
    let!(:params) do
      {
        api_token: api_token,
        event_name: event_name,
        ip_address: ip_address,
        email: email,
      }
    end

    context 'invalid credentials' do
      let!(:api_token) { '' }
      let(:event_name) { 'login_failed' }
      let(:ip_address) { Faker::Internet.ip_v4_address }
      let(:email) { Faker::Internet.email }

      before do
        subject
      end

      it 'returns correct message' do
        expect(JSON.parse(response.body)['error']).to(eq('Invalid ApiToken'))
      end

      it 'returns correct http status' do
        expect(response).to(have_http_status(401))
      end
    end

    context 'valid credentials' do
      context 'invalid parameters' do
        context 'empty event_name' do
          let(:event_name) { '' }
          let(:ip_address) { Faker::Internet.ip_v4_address }
          let(:email) { Faker::Internet.email }

          before do
            subject
          end

          it 'returns correct http status' do
            expect(response).to(have_http_status(422))
          end

          it 'returns correct error message' do
            expect(JSON.parse(response.body)).to(eq({ 'event_name' => ['must be filled'] }))
          end
        end

        context 'empty ip_address' do
          let(:event_name) { 'login_failed' }
          let(:ip_address) { '' }
          let(:email) { Faker::Internet.email }

          before do
            subject
          end

          it 'returns correct http status' do
            expect(response).to(have_http_status(422))
          end

          it 'returns correct error message' do
            expect(JSON.parse(response.body)).to(eq({ 'ip_address' => ['must be filled'] }))
          end
        end

        context 'empty email' do
          let(:event_name) { 'login_failed' }
          let(:ip_address) { Faker::Internet.ip_v4_address }
          let(:email) { '' }

          before do
            subject
          end

          it 'returns correct http status' do
            expect(response).to(have_http_status(422))
          end

          it 'returns correct error message' do
            expect(JSON.parse(response.body)).to(eq({ "email" => ["must be filled"] }))
          end
        end

        context 'invalid event_name' do
          let(:event_name) { 'registration_failed' }
          let(:ip_address) { Faker::Internet.ip_v4_address }
          let(:email) { Faker::Internet.email }

          before do
            subject
          end

          it 'returns correct http status' do
            expect(response).to(have_http_status(422))
          end

          it 'returns correct error message' do
            expect(JSON.parse(response.body)).to(eq({ "event_name" => ["must be equal to login_failed"] }))
          end
        end
      end

      context 'valid parameters' do
        let(:event_name) { 'login_failed' }
        let(:ip_address) { Faker::Internet.ip_v4_address }
        let(:email) { Faker::Internet.email }

        context 'accepted authentication request' do
          before do
            allow(AnalyseAuthenticationEvent).to(receive(:call).and_return(true))
            subject
          end

          it 'returns correct http status' do
            expect(response).to(have_http_status(200))
          end

          it 'returns correct message' do
            expect(JSON.parse(response.body)).to(eq('message' => "Next login request permitted."))
          end
        end

        context 'not accepted authentication request' do
          before do
            allow(AnalyseAuthenticationEvent).to(receive(:call).and_return(false))
            subject
          end

          it 'returns correct http status' do
            expect(response).to(have_http_status(200))
          end

          it 'returns correct message' do
            expect(JSON.parse(response.body)).to(eq('message' => "User hits login limitations. Ip address banned for #{ip_ban_settings_set.ban_duration} seconds."))
          end
        end
      end
    end
  end
end
