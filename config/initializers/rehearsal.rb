# Rehearsals use a disposable database and never send mail or execute jobs.
if ENV['APP_REHEARSAL'] == '1'
  Rails.application.config.action_mailer.delivery_method = :test
  Rails.application.config.action_mailer.perform_deliveries = false
  Rails.application.config.active_job.queue_adapter = :test
end
