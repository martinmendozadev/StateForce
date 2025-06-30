require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  test "job class is defined and inherits from ActiveJob::Base" do
    assert ApplicationJob < ActiveJob::Base
  end

  test "job is enqueued successfully" do
    assert_enqueued_with(job: ApplicationJob) do
      ApplicationJob.perform_later
    end
  end
end
