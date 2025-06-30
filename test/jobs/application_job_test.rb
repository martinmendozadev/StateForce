require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  test "job is enqueued successfully" do
    assert_enqueued_with(job: ApplicationJob) do
      ApplicationJob.perform_later({ foo: "bar" })
    end
  end

  test "job is enqueued with default queue" do
    assert_enqueued_with(job: ApplicationJob, queue: "default") do
      ApplicationJob.perform_later({ foo: "bar" })
    end
  end

  test "job performs successfully" do
    assert_nothing_raised do
      perform_enqueued_jobs do
        ApplicationJob.perform_later({ foo: "bar" })
      end
    end
  end

  test "job logs arguments when performed" do
    perform_enqueued_jobs do
      assert_logs(/ApplicationJob performed with arguments: \[{:foo=>"bar"}\]/) do
        ApplicationJob.perform_later({ foo: "bar" })
      end
    end
  end
end
