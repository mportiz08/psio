require 'rake'

task :default => [:build]

desc 'Builds the psiod python module.'
task 'build:psiod' do
  sh 'sudo pip install --upgrade --no-deps ./psiod'
end

desc 'Builds the psiod python module and its dependencies.'
task :build do
  sh 'sudo pip install --upgrade ./psiod'
  cd 'frontend' do
    sh 'bundle install'
  end
end

desc 'Starts the frontend server.'
task :server do
  cd 'frontend' do
    sh 'bundle exec thin start'
  end
end
