web: bundle exec puma -t 16:16 -p ${PORT:-3000}
release: bundle exec rake db:migrate
mainworker: bundle exec sidekiq -e production -c 10 -q critical -q default
