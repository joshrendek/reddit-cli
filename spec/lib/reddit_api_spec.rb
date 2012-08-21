require 'spec_helper'
require './lib/reddit_api'

describe RedditApi do 
    let(:reddit) { RedditApi.new('ProgrammerHumor') }
    context "#initializing" do 
        it "should form the correct endpoint" do 
            VCR.use_cassette('reddit_programmer_humor') do 
                reddit.url.should eq "http://reddit.com/r/ProgrammerHumor/.json?after="
            end
        end
    end

    context "#fetching" do 
        it "should fetch the first page of stories" do 
            VCR.use_cassette('reddit_programmer_humor') do 
                reddit.stories.count.should eq(25)
            end
        end

        it "should fetch the second page of stories" do 
            VCR.use_cassette('reddit_programmer_humor_p2') do 
                reddit.next.stories.count.should eq(25)
            end
        end
    end
end
