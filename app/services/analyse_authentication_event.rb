# frozen_string_literal: true

require "redis"

class AnalyseAuthenticationEvent < ApplicationService
  def initialize(params)
    @api_token = params[:api_token]
    @event_name = params[:event_name]
    @ip_address = params[:ip_address]
    @email = params[:email]
    @ban_duration = params[:ban_duration] || 180
    @number_of_permitted_failed_requests = params[:number_of_permitted_failed_requests] || 10
    @check_duration = params[:check_duration] || 60
    @number_of_emails_within_check = params[:number_of_emails_within_check] || 10
    @request_allowed = true
  end

  def call
    @redis = Redis.new

    if @redis.get(authentication_key)
      number_of_requests_with_same_email = increase_counter

      if number_of_requests_with_same_email > @number_of_permitted_failed_requests
        ban_ip_address
      end

    else
      add_authentication_key_counter
    end

    if amount_of_request_with_same_ip_address > @number_of_emails_within_check
      ban_ip_address
    end

    @request_allowed
  end

  private

  def authentication_key
    @authentication_key ||= "counter:#{@api_token}:#{@ip_address}:#{@email}"
  end

  def blocked_authentication_key
    @blocked_authentication_key ||= "ban:#{@api_token}:#{@ip_address}"
  end

  def increase_counter
    @redis.incr(authentication_key)
  end

  def ban_ip_address
    @redis.set(blocked_authentication_key, 1)
    @redis.expire(blocked_authentication_key, @ban_duration)
    @request_allowed = false
  end

  def add_authentication_key_counter
    @redis.set(authentication_key, 1)
    @redis.expire(authentication_key, @check_duration)
  end

  def amount_of_request_with_same_ip_address
    events = @redis.scan(0, match: "counter:#{@api_token}:#{@ip_address}:*")[1]
    events.sum do |events_key|
      @redis.get(events_key)&.to_i || 0
    end
  end
end
