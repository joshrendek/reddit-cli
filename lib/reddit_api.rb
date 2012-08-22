require 'json'
require 'rest-client'
require './lib/story'

class RedditApi
    REDDIT_URL = "http://reddit.com/r/"
    attr_reader :url, :stories
    def initialize(subreddit)
        @subreddit = subreddit
        @after = ""
        @url = "#{REDDIT_URL}#{subreddit}/.json?after=#{@after}"
        request
        process_request
    end

    def next 
        @url = "#{REDDIT_URL}#{@subreddit}/.json?after=#{@after}"
        request
        process_request
        self
    end

    def request 
        @request_response = JSON.parse(RestClient.get(@url))
    end

    def process_request 
        @stories = []
        @request_response['data']['children'].each do |red| 
            d = red['data']
            @stories << Story.new(d['title'], d['score'], 
                                  d['num_comments'], d['url'])
        end
        @after = @request_response['data']['after']
    end

end

