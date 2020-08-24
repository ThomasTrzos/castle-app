# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'application#index'

  namespace 'api' do
    namespace 'v1' do
      namespace 'authentication_events' do
        get 'analyse'
      end
    end
  end
end
