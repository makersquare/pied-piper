# url = URI.parse(ENV['REDISTODO_URL'])
# Redis.new(:url => url)
$redis = Redis.new(host: 'localhost', port: 6379)
