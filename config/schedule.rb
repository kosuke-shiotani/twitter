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

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")

# cronのログ出力場所を設定
set :output, "#{Rails.root}/log/cron.log"

# schedule.rb内でrbenvの設定が効かないのでrbenvを初期化する
job_type :rake, 'export PATH="/Users/sasayaryouta/.anyenv/envs/rbenv/shims:/Users/sasayaryouta/.anyenv/envs/rbenv/bin:/Users/sasayaryouta/.anyenv/envs/nodenv/shims:/Users/sasayaryouta/.anyenv/envs/nodenv/bin:/Users/sasayaryouta/.anyenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/sasayaryouta/.fzf/bin"; eval "$(rbenv init -)"; cd :path &&  bundle exec rake :task :output'

every 1.minutes do
    begin
        rake 'amazon_scraping:start', environment => 'development'
        command "echo 'rake task finished'"
    rescue => exception
        raise exception
        command "echo 'rake task stopped'"
    end
end

=begin
コマンド説明()

# schedule.rb内を読み込む(構文エラーなどがあると検出)
bundle exec whenever

# 上でAbove is your schedule file ...とでたら読み込めているのでこのコマンドでcrontabに処理を登録
bundle exec whenever --update-crontab
bundle exec whenever --write-crontab

# あとは/log/cron.log内に結果が出力される

# schedule.rbで定義したcrontabを削除
bundle exec whenever --clear-crontab

=end
