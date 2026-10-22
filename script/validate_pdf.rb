# Regression checks for selectable PDF text, not an ATS certification or ranking.
require 'yaml'
require 'cgi'
require 'open3'

ROOT = File.expand_path('..', __dir__)
OUTPUT = File.expand_path(ARGV.fetch(0, 'preview-artifacts'))
def read_data(lang, name)
  YAML.safe_load(File.read(File.join(ROOT, '_data', lang, "#{name}.yml")))
end
def plain(value)
  CGI.unescapeHTML(value.to_s.gsub(/<[^>]*>/, ' ')).unicode_normalize(:nfc).gsub(/[[:space:]]+/, ' ').strip
end
def run!(*args)
  output, error, status = Open3.capture3(*args)
  raise "#{args.first} failed: #{error}" unless status.success?
  output
end
def assert!(condition, message)
  raise message unless condition
end
config = YAML.safe_load(File.read(File.join(ROOT, '_config.yml')))
%w[en es].each do |lang|
  path = File.join(OUTPUT, "cv-#{lang}.pdf")
  info = run!('pdfinfo', path)
  assert!(info.match?(/^Pages:\s+2$/), "#{lang}: expected exactly two pages")
  assert!(info.match?(/^Page size:.*\(A4\)/), "#{lang}: expected A4 paper")
  assert!(File.size(path) < 2_500_000, "#{lang}: PDF exceeds conservative 2.5 MB budget")
  fonts = run!('pdffonts', path).lines.drop(2).reject { |line| line.strip.empty? }
  assert!(!fonts.empty?, "#{lang}: no PDF fonts found")
  fonts.each do |line|
    columns = line.split
    assert!(columns[-5] == 'yes' && columns[-3] == 'yes', "#{lang}: font must be embedded and have Unicode mapping: #{line}")
  end
  strings = read_data(lang, 'strings')
  headings = %w[print_summary_heading section_experience section_projects section_skills section_certifications section_education].map { |key| strings.fetch(key) }
  %w[reading layout].each do |mode|
    args = mode == 'layout' ? ['-layout'] : []
    raw = run!('pdftotext', '-enc', 'UTF-8', *args, path, '-')
    assert!(!raw.include?("\uFFFD"), "#{lang}/#{mode}: replacement characters in extracted text")
    text = plain(raw)
    expected = [config.fetch('resume_name'), config.fetch('resume_contact_email'), 'linkedin.com/in/christiangrimberg', strings.fetch('job_title')]
    expected += read_data(lang, 'experience').flat_map { |job| [job.fetch('company'), job.fetch('position'), job.fetch('duration')] }
    expected += read_data(lang, 'recognitions').select { |item| item['kind'] == 'certification' }.map { |item| item.fetch('award') }
    expected += read_data(lang, 'education').flat_map { |item| [item.fetch('degree'), item.fetch('uni'), item.fetch('year')] }
    expected += ['Azure DevOps', '.NET', 'SQL Server', 'PowerShell', 'Microsoft Fabric', 'Microsoft 365 Copilot', 'Copilot Studio']
    expected.each { |value| assert!(text.include?(plain(value)), "#{lang}/#{mode}: missing readable text: #{plain(value)}") }
    cursor = 0
    headings.each do |heading|
      index = text.index(plain(heading), cursor)
      assert!(!index.nil?, "#{lang}/#{mode}: missing or out-of-order section: #{heading}")
      cursor = index + plain(heading).length
    end
    jobs = read_data(lang, 'experience').first(3)
    jobs.each do |job|
      pair = "#{plain(job['company'])} #{plain(job['position'])}"
      assert!(text.include?(pair), "#{lang}/#{mode}: employer not associated with role: #{job['position']}")
    end
  end
  puts "#{lang}: two-page A4, embedded Unicode fonts, readable contact/roles/dates/credentials and ordered sections passed."
end
puts 'PDF readability checks passed. No commercial ATS parser or job-specific ranking was tested.'
