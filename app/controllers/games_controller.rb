require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
    # @grid_string = @letters.join('')
  end

  def website(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    response = open(url).read
    attempt_response = JSON.parse(response)
    return attempt_response
  end

  def message(attempt, grid)
    ref_attempt = attempt.upcase.chars
    ref_grid = grid.chars
    if ref_attempt.all? { |e| ref_grid.include?(e) } == false # || impr_m.all? { |e| impr_m.count(e) > grid.count(e) }
      return "Sorry but #{attempt} can't be build out of #{grid}"
    elsif website(attempt)['found'] == false
      return "Sorry but #{attempt} does not seem to be a valid English word..."
    # count frequency of chars in attempt and compare to frequency in grid
    #elsif ref_attempt.all? { |e| grid.include?(e) } && ref_attempt.all? { |i| ref_attempt.count(i) > grid.count(i) }
     # return "Sorry but #{attempt} does not seem to be a valid English word..."
    else
      return "Congratulations! #{attempt} is a valid English word!"
    end
  end

  def score
    @input = params[:word]
    @grid = params[:grid]
    @output = message(@input, @grid)
  end
end
