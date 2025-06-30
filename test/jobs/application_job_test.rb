require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  test "job is enqueued successfully" do
    assert_enqueued_with(job: ApplicationJob) do
      ApplicationJob.perform_later
    end
  end

  test "job performs successfully" do
    assert_nothing_raised do
      perform_enqueued_jobs do
        ApplicationJob.perform_later
      end
    end
  end
end
