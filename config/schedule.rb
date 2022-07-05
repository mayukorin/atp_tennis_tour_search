# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + '/environment')
rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env

set :output, "#{Rails.root}/log/cron.log"

ENV.each { |k, v| env(k, v) }

job_type :rake, "cd :path && :environment_variable=:environment bundle exec rake :task --silent :output"

every 1.hours do
    rake 'tennis:fetch_match_info'
end

every 1.week do
    rake 'tennis:fetch_player_ranking_info'
end

every 1.day, :at => '10:40 pm' do
    rake 'tennis:line_notify_tournament_start'
end

every 1.day,  :at => '11:00 pm' do
    rake 'tennis:line_notify_favorite_player_match_before_day'
end

every 1.hours do
    rake 'tennis:line_notify_favorite_player_match_before_one_hour'
end