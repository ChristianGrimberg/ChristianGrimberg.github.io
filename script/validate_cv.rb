require 'yaml'
require 'set'
root = File.expand_path('..', __dir__)
read = ->(lang, file) { YAML.safe_load(File.read(File.join(root, '_data', lang, "#{file}.yml"))) }
raise 'Translation keys differ' unless read.call('en', 'strings').keys.to_set == read.call('es', 'strings').keys.to_set
%w[en es].each do |lang|
  projects = read.call(lang, 'projects')
  raise "Expected 37 projects in #{lang}" unless projects.size == 37
  raise 'Duplicate project IDs' unless projects.map { |p| p['id'] }.uniq.size == projects.size
  raise 'Expected six featured projects' unless projects.count { |p| p['featured'] } == 6
  courses = read.call(lang, 'continuing-education')
  raise 'Community recognition duplicated as course' if courses.any? { |c| c['name'].include?('Microsoft Active Professional') }
  prefix = lang == 'es' ? 'es/' : ''
  ["#{prefix}index.html", "#{prefix}cv/index.html"].each do |page|
    html = File.read(File.join(root, '_site', page))
    raise "Unrendered Liquid in #{page}" if html.include?('{{') || html.include?('{%')
    raise "Missing role in #{page}" unless html.include?(read.call(lang, 'strings')['job_title'])
    raise "Unexpected venture mention in #{page}" if html.match?(/BairesCoding/i)
  end
end
puts 'Bilingual CV validation passed.'
