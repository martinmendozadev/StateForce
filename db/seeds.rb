# frozen_string_literal: true

require 'faker'

# Crear usuarios aleatorios
10.times do
  login_google = rand(0..1)

  if login_google == 1
    google_auth = Faker::Omniauth.google

    User.find_or_create_by!(email: google_auth[:info][:email]) do |user|
      user.avatar_url = google_auth[:info][:image]
      user.first_name = google_auth[:info][:first_name]
      user.last_name = google_auth[:info][:last_name]
      user.uid = google_auth[:uid]
      user.provider = google_auth[:provider]
      user.role = rand(0..2)
      user.confirmed_at = Time.current
    end
  else
    User.find_or_create_by!(email: Faker::Internet.unique.email) do |user|
      user.password = '123qweASD'
      user.password_confirmation = '123qweASD'
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.phone = Faker::PhoneNumber.phone_number
      user.role = rand(0..2)
      user.confirmed_at = Time.current
    end
  end
end

# Default user config to Development
User.find_or_create_by!(email: 'test@stateforce.mx') do |user|
  user.confirmed_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
  user.first_name = 'Test'
  user.last_name = 'User'
  user.password = '123qweASD'
  user.password_confirmation = '123qweASD'
  user.phone = '+525555555555'
  user.role = 2
end

Rails.logger.debug 'Seed data created successfully!'
