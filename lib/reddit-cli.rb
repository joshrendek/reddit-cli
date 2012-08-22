require './lib/reddit_api'
require 'terminal-table'
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
        puts Terminal::Table.new :headings=> ['#', 'Score', 'Comments', 'Title'], :rows => @rows    
    end

    def prompt 
        print "\n?> "
        input = STDIN.gets.chomp
        case input 
        when "?"
            p "Type the # of a story to open it in your browser"
            p "Type n to go to the next page"
            prompt
        when "quit", "q"
        when "n"
            @rows = []
            @stories = @api.next.stories 
            print_stories
            prompt
        else 
            print "#=> Oepning: #{@stories[input.to_i].url}"
            `open #{@stories[input.to_i].url}`
            prompt
        end
    end
end

