if Rails.env.test?
  Delayed::Worker.delay_jobs = false
end
