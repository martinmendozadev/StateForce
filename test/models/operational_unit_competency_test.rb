require "test_helper"

class OperationalUnitCompetencyTest < ActiveSupport::TestCase
  def setup
    @ouc = operational_unit_competencies(:one)
  end

  test "fixture is valid" do
    assert @ouc.valid?
  end

  test "should require operational_unit_id" do
    @ouc.operational_unit_id = nil
    assert_not @ouc.valid?
  end

  test "should require competency_id" do
    @ouc.competency_id = nil
    assert_not @ouc.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = OperationalUnitCompetency.new(
      operational_unit: @ouc.operational_unit,
      competency: @ouc.competency
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
