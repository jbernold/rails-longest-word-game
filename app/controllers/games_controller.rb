require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a[rand(25)] }
  end


  def score
    @letters = params[:letters].gsub(/\s+/, "")
    @word = params[:word].upcase
    @message = "Congratulations! #{@word} is a valid English word!"
    @word.chars.each do |char|
      @message = "Sorry but #{@word} can't be built out of #{@letters.chars.join(', ')}" unless @word.chars.count(char) <= @letters.chars.count(char)
    end
    @message = "#{@word} is not an English word, loser." unless JSON.parse(open('https://wagon-dictionary.herokuapp.com/' + @word).read)["found"]
  end
end






# def english(attempt)
#   url = 'https://wagon-dictionary.herokuapp.com/' + attempt
#   return HTTParty.get(url)["found"]
# end

# def run_game(attempt, grid, start_time, end_time)
#   # TODO: runs the game and return detailed hash of result
#   time = end_time - start_time
#   score = 100 * attempt.size / time
#   message = "well done"

#   score = 0 unless in_grid(attempt, grid) && english(attempt)
#   message = "#{attempt} is not in the grid, loser." unless in_grid(attempt, grid)
#   message = "#{attempt} is not an English word, loser." unless english(attempt)

#   result = { time: time, score: score, message: message }
#   return result
# end
