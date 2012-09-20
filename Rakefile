require 'rake'

task :default => [:build]

desc 'Builds the psiod python module.'
task :build do
  sh 'sudo pip install --upgrade --no-deps ./psiod'
end

desc 'Builds the psiod python module and its dependencies.'
task :buildall do
  sh 'sudo pip install --upgrade ./psiod'
end
