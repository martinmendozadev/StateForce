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
25.times do
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

# Create fake schedule entries
10.times do
  ScheduleEntry.create(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    priority_level: ScheduleEntry.priority_levels.keys.sample,
    recurrence_rule: ScheduleEntry.recurrence_rules.keys.sample,
    status: ScheduleEntry.statuses.keys.sample,
    visibility: ScheduleEntry.visibilities.keys.sample,
    creator_user_id: User.order('RANDOM()').first.id,
    event_id: Event.order('RANDOM()').first.id,

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

resource_types = [
  { name: "Ambulance", description: "Emergency vehicles equipped for patient transport.", category: "Rescue Vehicles" },
  { name: "Fire Truck", description: "Specialized vehicles for firefighting operations.", category: "Rescue Vehicles" },
  { name: "Helicopter", description: "Airborne vehicles for rapid emergency response.", category: "Rescue Vehicles" },
  { name: "Defibrillator", description: "Medical equipment for cardiac emergencies.", category: "Medical Equipment" },
  { name: "Ventilator", description: "Critical equipment for respiratory support.", category: "Medical Equipment" }
]

resource_categories.each_with_index do |attrs, i|
  ResourceCategory.find_or_create_by!(name: attrs[:name]) do |category|
    category.description = attrs[:description]
    ResourceType.create!(
      name: resource_types[i][:name],
      description: resource_types[i][:description],
      resource_category: category
    )
  end
end

# Create fake resources
10.times do
  Resource.create(
    name: Faker::Vehicle.model,
    description: Faker::Vehicle.make_and_model,
    available_units: rand(1..5),
    total_units: rand(5..10),
    units_identifier: Faker::Alphanumeric.alpha(number: 10),
    institution: Institution.order("RANDOM()").first,
    resource_type: ResourceType.order("RANDOM()").first,
    location: Location.order("RANDOM()").first
  )
end

# Create fake patient transfers
10.times do
  PatientTransfer.create(
    arrival_time: Faker::Time.forward(days: 1),
    departure_time: Faker::Time.backward(days: 1),
    status: PatientTransfer.statuses.keys.sample,
    accepted_by_user: User.order("RANDOM()").first,
    destination_institution: Institution.order("RANDOM()").first,
    event: Event.order("RANDOM()").first,
    patient: Patient.order("RANDOM()").first,
    requesting_user: User.order("RANDOM()").first,
    transport_resource: Resource.order("RANDOM()").first
  )
end

# Create fake audit logs
10.times do
  AuditLog.create(
    action: AuditLog.actions.keys.sample,
    entity_id: rand(1..10),
    entity_name: AuditLog.entity_names.keys.sample,
    new_value: Faker::Json.shallow_json,
    old_value: Faker::Json.shallow_json,
    user: User.order("RANDOM()").first
  )
end

# Create fake operational units
10.times do
  OperationalUnit.create(
    coverage: Faker::Lorem.paragraph,
    name: Faker::Company.name,
    parent_institution: Institution.order("RANDOM()").first,
    location: Location.order("RANDOM()").first,
    on_charge_shift_user: User.order("RANDOM()").first,
    triage_status: OperationalUnit.triage_statuses.keys.sample,
    facility_type: OperationalUnit.facility_types.keys.sample
  )
end

# Create fake medical center profiles
10.times do
  MedicalCenterProfile.create(
    operational_unit: OperationalUnit.order("RANDOM()").first,
    external_pharmacy_available: [ true, false ].sample,
    internal_pharmacy_available: [ true, false ].sample,
    level: MedicalCenterProfile.levels.keys.sample,
    operating_rooms_total: rand(1..5),
    operating_rooms_available: rand(1..5)
  )
end

# Create bed inventories
10.times do
  BedInventory.create(
    operational_unit: OperationalUnit.order("RANDOM()").first,
    bed_type: BedInventory.bed_types.keys.sample,
    available: rand(1..5),
    total: rand(5..10)
  )
end

# Create user callsigns
3.times do
  UserCallsign.create!(
    callsign: Faker::Alphanumeric.alpha(number: 6).upcase,
    user: User.order("RANDOM()").first,
    institution: Institution.order("RANDOM()").first
  )
end

# Create specialties
specialties = [
  { id: 1, name: "Cardiology", description: "Specializes in diagnosing and treating heart conditions.", code: "CARD-001" },
  { id: 2, name: "Pediatrics", description: "Focuses on the medical care of infants, children, and adolescents.", code: "PED-005" }
]

specialties.each do |attrs|
  Specialty.find_or_create_by!(name: attrs[:name]) do |specialty|
    specialty.description = attrs[:description]
    specialty.code = attrs[:code]
    specialty.id = attrs[:id]
  end
end

# Create competencies
competencies = [
  { specialty: specialties[0], level: "basic" },
  { specialty: specialties[0], level: "advanced" },
  { specialty: specialties[1], level: "basic" }
]

competencies.each do |attrs|
  Competency.find_or_create_by!(specialty_id: attrs[:specialty][:id], level: attrs[:level])
end

# Create user institutions
10.times do
  UserInstitution.find_or_create_by!(user: User.order("RANDOM()").first, institution: Institution.order("RANDOM()").first) do |ui|
    ui.position = Faker::Job.position
    ui.role = UserInstitution.roles.keys.sample
    ui.status = UserInstitution.statuses.keys.sample
  end
end

# Create user competencies
10.times do
  UserCompetency.find_or_create_by!(user: User.order("RANDOM()").first, competency: Competency.order("RANDOM()").first) do |uc|
    uc.expiry_date = Faker::Date.forward(days: 30)
  end
end

# Create operational unit notes
10.times do
  OperationalUnitNote.find_or_create_by!(operational_unit: OperationalUnit.order("RANDOM()").first, note: Note.order("RANDOM()").first) do |oun|
    oun.created_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
    oun.updated_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
  end
end

# Create event institutions
10.times do
  EventInstitution.find_or_create_by!(event: Event.order("RANDOM()").first, institution: Institution.order("RANDOM()").first) do |ei|
    ei.assigned_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
  end
end

# Create event resources
10.times do
  EventResource.find_or_create_by!(event: Event.order("RANDOM()").first, resource: Resource.order("RANDOM()").first, assigned_by_user: User.order("RANDOM()").first) do |er|
    er.quantity_assigned = rand(1..5)
    er.assigned_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
  end
end

# Create operational unit competencies
10.times do
  OperationalUnitCompetency.find_or_create_by!(operational_unit: OperationalUnit.order("RANDOM()").first, competency: Competency.order("RANDOM()").first) do |ouc|
    ouc.created_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
    ouc.updated_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
  end
end

# Create institution contacts
10.times do
  InstitutionContact.find_or_create_by!(institution: Institution.order("RANDOM()").first, contact: Contact.order("RANDOM()").first) do |ic|
    ic.contact_type = InstitutionContact.contact_types.keys.sample
  end
end

# Create phone number associations
10.times do
  UserContact.find_or_create_by!(user: User.order("RANDOM()").first, contact: Contact.order("RANDOM()").first) do |uc|
    uc.contact_type = UserContact.contact_types.keys.sample
  end
end

# Create contact phone numbers
10.times do
  ContactPhoneNumber.find_or_create_by!(contact: Contact.order("RANDOM()").first, phone_number: PhoneNumber.order("RANDOM()").first) do |cpn|
    cpn.is_primary = [ true, false ].sample
  end
end

# Create user notes
10.times do
  UserNote.find_or_create_by!(user: User.order("RANDOM()").first, note: Note.order("RANDOM()").first) do |un|
    un.starred = [ true, false ].sample
  end
end

# Create institution attachments
10.times do
  InstitutionAttachment.find_or_create_by!(institution: Institution.order("RANDOM()").first, attachment: Attachment.order("RANDOM()").first)
end

# Create operational unit attachments
10.times do
  OperationalUnitsAttachment.find_or_create_by!(operational_unit: OperationalUnit.order("RANDOM()").first, attachment: Attachment.order("RANDOM()").first)
end

# Create event attachments
10.times do
  EventAttachment.find_or_create_by!(event: Event.order("RANDOM()").first, attachment: Attachment.order("RANDOM()").first)
end

# Create resource attachments
10.times do
  ResourceAttachment.find_or_create_by!(resource: Resource.order("RANDOM()").first, attachment: Attachment.order("RANDOM()").first)
end

# Create schedule entries institutions
10.times do
  ScheduleEntriesInstitution.find_or_create_by!(schedule_entry: ScheduleEntry.order("RANDOM()").first, institution: Institution.order("RANDOM()").first)
end

# Create event notes
10.times do
  EventNote.find_or_create_by!(event: Event.order("RANDOM()").first, note: Note.order("RANDOM()").first) do |en|
    en.created_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
    en.updated_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
  end
end

# Create note editors
10.times do
  NoteEditor.find_or_create_by!(note: Note.order("RANDOM()").first, user: User.order("RANDOM()").first) do |ne|
    ne.last_edited_at = Faker::Time.between(from: 2.days.ago, to: Time.zone.today)
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
