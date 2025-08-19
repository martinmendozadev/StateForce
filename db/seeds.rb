# frozen_string_literal: true

require 'faker'

# Create fake locations
9.times do
  Location.create(
    address: Faker::Address.full_address,
    key_name: Faker::Address.secondary_address,
    place_name: Faker::Address.community,
    coordinates: RGeo::Geographic.spherical_factory(srid: 4326).point(
      Faker::Address.longitude,
      Faker::Address.latitude
    ),
    created_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today),
    updated_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today)
  )
end

# Create fake user
users = 9.times do
  login_google = rand(0..1)

  if login_google == 1
    google_auth = Faker::Omniauth.google

    User.find_or_create_by!(email: google_auth[:info][:email]) do |user|
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

# Create fake attachments
9.times do
  file_type = Attachment.file_types.keys.sample
  visibility = Attachment.visibilities.keys.sample

  Attachment.create(
    content_type: Faker::File.mime_type,
    description: Faker::Lorem.sentence(word_count: 10),
    file_name: Faker::File.unique.file_name(dir: 'uploads', ext: file_type.to_s),
    file_size: Faker::Number.between(from: 1_000, to: 10_000),
    file_type:,
    file_url: Faker::Internet.unique.url(host: 'stateforce.mx', path: "/uploads/#{file_type}/#{Faker::File.unique.file_name(dir: 'uploads', ext: file_type.to_s)}"),
    visibility:,
    uploader_user_id: 1,
    created_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today),
    updated_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today)
  )
end

# Create fake notes
9.times do
  Note.create(
    body: Faker::Lorem.paragraph(sentence_count: 3),
    title: Faker::Lorem.sentence(word_count: 5),
    visibility: Note.visibilities.keys.sample,
    creator_user_id: 1,
    created_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today),
    updated_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today)
  )
end

# Create fake institutions
9.times do
  Institution.create(
    name: Faker::Company.unique.name,
    callsign: Faker::Company.unique.ein,
    description: Faker::Lorem.paragraph,
    sector_type: Institution.sector_types.keys.sample,
    status: Institution.statuses.keys.sample,
    location: Location.order('RANDOM()').first
  )
end

# Create fake events
9.times do
  Event.create!(
    description: Faker::Lorem.sentence,
    ended_at: Faker::Time.forward(days: 1),
    event_type: Event.event_types.keys.sample,
    event_code: Faker::Alphanumeric.unique.alphanumeric(number: 10),
    priority_level: Event.priority_levels.keys.sample,
    people_affected: Faker::Number.between(from: 1, to: 32767),
    reported_by_text: Faker::Lorem.sentence,
    reported_time: Faker::Time.backward(days: 1),
    status: Event.statuses.keys.sample,
    location: Location.order('RANDOM()').first,

    created_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today),
    updated_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today)
  )
end

# Default user config to Development
User.find_or_create_by!(email: 'test@stateforce.mx') do |user|
  user.confirmed_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
  user.name = 'Test User'
  user.password = '123qweASD'
  user.password_confirmation = '123qweASD'
end

Rails.logger.debug 'Seed data created successfully!'
