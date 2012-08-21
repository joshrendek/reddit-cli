require './lib/reddit_api'
require 'terminal-table'
require 'pry'

subreddit = ARGV[0]

class RedditCli 
    def initialize(api) 
        @rows = []
        @api = api
        @stories = api.stories
        print_stories
        print "\nType ? for help\n"
        prompt 
    end

    def print_stories
        @stories.each_with_index {|x, i| @rows << [i, x.score, x.comments, x.title[0..79] ] }
        p Terminal::Table.new :headings=> ['#', 'Score', 'Comments', 'Title'], :rows => @rows    
    end

    def prompt 
        print "\n?> "
        input = STDIN.gets.chomp
        case input 
        when "?"
            p "Type the # of a story to open it in your browser"
            p "Type n to go to the next page"
        when "n"
            @rows = []
            @stories = @api.next.stories 
            print_stories
        else 
            print "#=> Oepning: #{@stories[input.to_i].url}"
            `open #{@stories[input.to_i].url}`
        end
        prompt
    end
end

RedditCli.new(RedditApi.new(subreddit))
