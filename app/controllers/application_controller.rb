# frozen_string_literal: true

class ApplicationController < ActionController::API
  def index
    render(plain: "CastleApp by Tomasz Trzos. Environment: #{Rails.env}")
  end
end
