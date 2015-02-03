require 'yard'
require 'rails/tasks'

# Define description of the next rake task
desc "Generate documentation with YARD"
# Define a task named "doc" that executes the passed in block
task :doc do
  `bin/yard`
end

Rake::Task["doc:app"].clear