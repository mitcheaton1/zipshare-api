require "rubocop/rake_task"

task default: :rubocop

desc "Run rubocop linter"
task :rubocop do
  RuboCop::RakeTask.new
end
