# frozen_string_literal: true

require 'faker'

# Create fake user
9.times do
  login_google = rand(0..1)

  if login_google == 1
    google_auth = Faker::Omniauth.google

    User.find_or_create_by!(email: google_auth[:info][:email]) do |user|
      user.avatar_url = google_auth[:info][:image]
      user.name = google_auth[:info][:name]
      user.uid = google_auth[:uid]
      user.provider = google_auth[:provider]
      user.confirmed_at = Faker::Time.between(from: 15.days.ago, to: Time.zone.today)
    end
  else
    User.find_or_create_by!(email: Faker::Internet.unique.email) do |user|
      user.password = '123qweASD'
      user.password_confirmation = '123qweASD'
      user.name = Faker::Name.name
      user.confirmed_at = Faker::Time.between(from: 15.days.ago, to: Time.zone.today)
    end
  end
end

# Default user config to Development
User.find_or_create_by!(email: 'test@stateforce.mx') do |user|
  user.confirmed_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
  user.name = 'Test User'
  user.password = '123qweASD'
  user.password_confirmation = '123qweASD'
end

Rails.logger.debug 'Seed data created successfully!'
