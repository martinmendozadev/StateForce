require "test_helper"

class CompetencyTest < ActiveSupport::TestCase
  def setup
    @competency = competencies(:one)
  end

  test "should be valid" do
    assert @competency.valid?
  end

  test "should require specialty" do
    @competency.specialty = nil
    assert_not @competency.valid?
  end

  test "should require level" do
    @competency.level = nil
    assert_not @competency.valid?
  end

  test "should enforce uniqueness of specialty and level" do
    duplicate = @competency.dup
    assert_not duplicate.valid?
  end

  test "level should accept valid enum values" do
    valid_levels = %w[advanced basic medium unknown]
    valid_levels.each_with_index do |lvl, idx|
      sp = Specialty.create!(name: "TestSpecialty-#{idx}-#{SecureRandom.hex(4)}", code: "TS#{idx}")
      competency = Competency.new(specialty: sp, level: lvl)
      assert competency.valid?, "#{lvl} should be valid"
    end
  end
end
