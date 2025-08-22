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
9.times do
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

# Create fake patients
10.times do
  Patient.create(
    name: Faker::Name.name,
    age: rand(0..100),
    gender: Patient.genders.keys.sample,
    triage_status: Patient.triage_statuses.keys.sample,
    event: Event.order("RANDOM()").first,

    created_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today),
    updated_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today)
  )
end

# Create fake patient vitals
10.times do
  PatientVital.create(
    blood_pressure_systolic: rand(90..140),
    blood_pressure_diastolic: rand(60..90),
    capillary_blood_glucose: rand(70..1000),
    glasgow_coma_score: '{"verbal_response": 4, "motor_response": 5, "eye_response": 3}',
    heart_rate: rand(40..150),
    oxygen_saturation: rand(75..98),
    recorded_at: Faker::Time.between(from: 15.days.ago, to: Time.zone.today),
    respiratory_rate: rand(8..30),
    temperature: rand(35.5..38.5),
    patient: Patient.order("RANDOM()").first,
    recorded_by_user: User.order("RANDOM()").first
  )
end

10.times do
  Contact.create!(
    email: Faker::Internet.unique.email,
    name: Faker::Name.name,
    radio_frequency: "#{rand(100..500)}.#{rand(100..999)} MHz",
    channel: rand(1..10)
  )
end

10.times do
  PhoneNumber.create!(
    extension: Faker::PhoneNumber.extension(length: 3),
    number: Faker::PhoneNumber.phone_number,
    phone_type: PhoneNumber.phone_types.keys.sample
  )
end

10.times do
  Invite.create!(
    email: Faker::Internet.email,
    expires_at: Faker::Time.forward(days: 10),
    role: Invite.roles.keys.sample,
    status: Invite.statuses.keys.sample,
    token: SecureRandom.hex(16),
    institution: Institution.order("RANDOM()").first,
    inviter: User.order("RANDOM()").first
  )
end

# Create fake resource categories
resource_categories = [
  { name: "Medical Equipment", description: "Includes all types of medical supplies and devices used in patient care." },
  { name: "Rescue Vehicles", description: "Covers ambulances, helicopters, and other emergency response vehicles." },
  { name: "Protective Gear", description: "Personal protective equipment such as helmets, gloves, and vests." },
  { name: "Food & Water Supplies", description: "Essential provisions for emergency response and relief." },
  { name: "Shelter Materials", description: "Tents, blankets, and construction materials for temporary housing." }
]

resource_categories.each do |attrs|
  ResourceCategory.find_or_create_by!(name: attrs[:name]) do |category|
    category.description = attrs[:description]
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
