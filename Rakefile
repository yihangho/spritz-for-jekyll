task default: [:build, :move]

task :build do
  sh "gem build spritz_for_jekyll.gemspec"
end

task move: [:build] do
  versions = []

  Dir.open(".").each do |x|
    if /^spritz_for_jekyll-(\d+\.\d+\.\d+)\.gem$/ =~ x
      versions << $1
    end
  end

  versions.each do |v|
    FileUtils.mv("spritz_for_jekyll-#{v}.gem", "builds/spritz_for_jekyll-#{v}.gem")
  end
end

task :push do
  versions = []

  Dir.open("builds").each do |x|
    if /^spritz_for_jekyll-(\d+)\.(\d+)\.(\d+)\.gem$/ =~ x
      versions << [$1.to_i, $2.to_i, $3.to_i]
    end
  end

  latest_version = versions.sort.last.join('.')

  sh "gem push builds/spritz_for_jekyll-#{latest_version}.gem"
end
