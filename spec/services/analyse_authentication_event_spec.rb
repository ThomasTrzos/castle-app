# frozen_string_literal: true

require 'rails_helper'

describe AnalyseAuthenticationEvent do
  describe '#call' do
    subject { described_class.new(params).call }

    let(:api_token) { '7fa70b97-c578-43aa-9f31-8e301e94e8c7' }
    let(:event_name) { 'login_failed' }
    let(:ip_address) { Faker::Internet.ip_v4_address }
    let(:email) { Faker::Internet.email }

    let!(:params) do
      {
        api_token: api_token,
        event_name: event_name,
        ip_address: ip_address,
        email: email,
        ban_duration: 60,
        number_of_permitted_failed_requests: 5,
        check_duration: 30,
        number_of_emails_within_check: 5,
      }
    end

    context 'same email and ip address' do
      let!(:email) { 'sample-user@email.com' }
      let!(:ip_address) { "216.150.182.208" }

      context 'first request' do
        it 'allows request' do
          expect(subject).to(eq(true))
        end
      end

      context '5 request one by one' do
        before do
          4.times { described_class.new(params).call }
        end

        it 'allows request' do
          expect(subject).to(eq(true))
        end
      end

      context '6 request one by one' do
        before do
          5.times { described_class.new(params).call }
        end

        it 'blocks request' do
          expect(subject).to(eq(false))
        end
      end
    end

    context 'same ip address using different emails' do
      let!(:ip_address) { "216.150.182.208" }

      context '5 requests with different emails' do
        before do
          4.times do
            params[:email] = Faker::Internet.email
            described_class.new(params).call
          end
        end

        it 'allows request' do
          params[:email] = Faker::Internet.email
          expect(described_class.new(params).call).to(eq(true))
        end
      end

      context '6 requests with different emails' do
        before do
          5.times do
            params[:email] = Faker::Internet.email
            described_class.new(params).call
          end
        end

        it 'allows request' do
          params[:email] = Faker::Internet.email
          expect(described_class.new(params).call).to(eq(false))
        end
      end
    end
  end
end
