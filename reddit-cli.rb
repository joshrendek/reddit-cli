require './lib/reddit_api'
require './lib/reddit-cli'

subreddit = ARGV[0]
RedditCli.new(RedditApi.new(subreddit))
