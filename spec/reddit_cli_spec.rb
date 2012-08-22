require 'spec_helper'
require 'stringio'
require './lib/reddit-cli'


describe RedditCli do 
    let(:subreddit) { "ProgrammerHumor" }
    context "#initializing" do 
        before(:all) do 
            $stdout = @fakeout = StringIO.new
        end
            
        it "should print out a story" do 
            api_response = double(RedditApi)
            api_response.stub!(:stories => 
                               [Story.new("StoryTitle", "Score", 
                                          "Comments", "URL")])
            VCR.use_cassette('reddit_programmer_humor') do 
                $stdin.should_receive(:gets).and_return("q")
                cli = RedditCli.new(api_response)
                $stdout = STDOUT
                @fakeout.string.include?('StoryTitle').should be_true
            end
        end
    end
end
