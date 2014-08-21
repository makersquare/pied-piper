# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Crm::Application.load_tasks

require 'rake'
require 'resque/tasks'
require 'resque/scheduler/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] ||= '*'
  ENV['BACKGROUND'] ||= 'yes'
  ENV['PIDFILE'] ||= './resque.pid'
end
