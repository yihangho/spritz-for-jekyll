TEST_DIR = File.expand_path(File.join("..", "..", "test_dir"), File.dirname(__FILE__))
JEKYLL_OUTPUT = File.join(File.dirname(TEST_DIR), "jekyll_output.txt")

Before do
  FileUtils.mkdir_p(TEST_DIR) unless File.exist?(TEST_DIR)
  Dir.chdir(TEST_DIR)

  File.open("_config.yml", "w") do |f|
    f.puts("gems: [spritz_for_jekyll]")
  end
end

After do
  Dir.chdir("..")
  FileUtils.rm_rf(TEST_DIR)   if File.directory?(TEST_DIR)
  FileUtils.rm(JEKYLL_OUTPUT) if File.exists?(JEKYLL_OUTPUT)
end

Given(/^I have the "(.*)" directory$/) do |dir|
  FileUtils.mkdir_p(dir)
end

Given(/^I have a post$/) do
  File.open("_posts/2000-01-01-test.md", "w") do |f|
    f.puts("---")
    f.puts("Title: test")
    f.puts("---")
    f.puts("This is a test post")
  end
end

Given(/^I have a post with "(.*?)" set to "(.*?)"$/) do |key, value|
  File.open("_posts/2000-01-01-test.md", "w") do |f|
    f.puts("---")
    f.puts("Title: test")
    f.puts("#{key}: #{value}")
    f.puts("---")
    f.puts("This is a test post")
  end
end

Given(/^I have a post with content "(.*?)"$/) do |content|
  File.open("_posts/2000-01-01-test.md", "w") do |f|
    f.puts("---")
    f.puts("Title: test")
    f.puts("---")
    f.puts(content)
  end
end

Given(/^I configure Spritz with client_id and url$/) do
  File.open("_config.yml", "a") do |f|
    f.puts("spritz:")
    f.puts("  client_id: 12345")
    f.puts("  url: https://www.example.com")
  end
end

Given(/^I configure Spritz with:$/) do |table|
  File.open("_config.yml", "a") do |f|
    f.puts("spritz:")
    table.hashes.each do |r|
      f.puts("  #{r["key"]}: #{r["value"]}")
    end
  end
end

Given(/^I configure the site with "(.*?)" set to "(.*?)"$/) do |key, value|
  File.open("_config.yml", "a") do |f|
    f.puts "#{key}: #{value}"
  end
end

When(/^I run jekyll (.*)$/) do |args|
  system "bundle exec jekyll #{args} --trace > #{JEKYLL_OUTPUT} 2>&1"
end

Then(/^I should have the "(.*)" directory$/) do |dir|
  assert File.directory?(dir), "#{dir} is not a directory"
end

Then(/^I should have the "(.*?)" file$/) do |file|
  assert File.exists?(file), "#{file} does not exist"
end

Then(/^the "(.*?)" file should match '(.*?)'$/) do |file, regexp|
  assert Regexp.new(regexp, Regexp::MULTILINE) =~ File.open(file).read
end

Then(/^the "(.*?)" file should have a div with "(.*?)" set to "(.*?)"$/) do |file, key, value|
  content = File.open(file).read
  assert /(?<tag>\<div.*?\>)/ =~ content, "#{file} does not have a div"
  assert Regexp.new("#{key}\\s*=\\s*('|\")#{value}('|\")", Regexp::MULTILINE) =~ tag, "#{key} is not set to #{value}"
end


Then(/^I should be warned that "(.*?)"$/) do |warning|
  assert File.open(JEKYLL_OUTPUT).read.match(warning)
end

Then(/^the "(.*?)" file should not match '(.*?)'$/) do |file, regexp|
  assert !(Regexp.new(regexp, Regexp::MULTILINE) =~ File.open(file).read)
end

Then(/^the "(.*?)" file should not have a div with "(.*?)" set to "(.*?)"$/) do |file, key, value|
  if /(?<tag>\<div.*?\>)/ =~ File.open(file).read
    assert !(Regexp.new("#{key}\\s*=\\s*('|\")#{value}('|\")", Regexp::MULTILINE) =~ tag)
  end
end
