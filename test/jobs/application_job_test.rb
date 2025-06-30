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
    log_output = StringIO.new
    Rails.logger = Logger.new(log_output)

    perform_enqueued_jobs do
      ApplicationJob.perform_later({ foo: "bar" })
    end

    log_output.rewind
    assert_match(/ApplicationJob performed with arguments: \[\{foo: \"bar\"\}\]/, log_output.read)
  ensure
    Rails.logger = ActiveSupport::Logger.new(STDOUT) # Restaurar el logger original
  end
end
