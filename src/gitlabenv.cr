require "gitlab"
require "URI"

# TODO: Write documentation for `Gitlabenv`
VERSION = "0.1.0"

gitlab = Gitlab.client(ENV["GITLAB_HOST"], ENV["GITLAB_TOKEN"])

if ARGV.empty?
  puts "You must pass the project path as argument"
  exit 1
else
  project_path = ARGV[0]
end

id = URI.encode_www_form(project_path)

variables = gitlab.project_variables(id)

variables.each do |variable|
  puts "export #{variable["key"]}=\"#{variable["value"]}\""
end
