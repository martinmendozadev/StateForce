class ApplicationJob < ActiveJob::Base
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError

  def perform(*args)
    # Basic implementation for testing purposes
    Rails.logger.info("ApplicationJob performed with arguments: #{args.inspect}")
  end
end
