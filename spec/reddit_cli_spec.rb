require 'spec_helper'
require './lib/reddit-cli'

describe RedditCli do 
    let(:subreddit) { "ProgrammerHumor" }
    context "#initializing" do 
        it "should print out a story" do 
            api_response = double(RedditApi)
            api_response.stub!(:stories => 
                               [Story.new("StoryTitle", "Score", 
                                          "Comments", "URL")])
            VCR.use_cassette('reddit_programmer_humor') do 
                STDIN.should_receive(:gets).and_return("q")
                STDOUT.should_receive(:puts).at_least(:once)
                cli = RedditCli.new(api_response)
            end
        end
    end
end
