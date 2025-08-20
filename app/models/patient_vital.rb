class PatientVital < ApplicationRecord
  ## Relationships
  belongs_to :patient
  belongs_to :recorded_by_user, class_name: "User"

  ## Validations
  validates :blood_pressure_systolic, :blood_pressure_diastolic,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 },
            allow_nil: true

  validates :capillary_blood_glucose,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1500 },
            allow_nil: true

  validates :heart_rate,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 },
            allow_nil: true

  validates :oxygen_saturation,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 },
            allow_nil: true

  validates :respiratory_rate,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 50 },
            allow_nil: true

  validates :temperature,
            numericality: { greater_than_or_equal_to: -100.0, less_than_or_equal_to: 150.0 },
            allow_nil: true

  validates :recorded_at, presence: true
end
