require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (('A'..'Z').to_a * 30).sample(10)
  end

  def score
    @word = params[:word]
    @grid = params[:letters]
    @result = if included?(@word.upcase, @grid)
                if english_word?(@word)
                  "<strong>Congratulations!</strong> #{@word.upcase} is a valid English Word".html_safe
                else
                  "Sorry but <strong>#{@word.upcase}</strong> does not seem to be a valid English Word...".html_safe
                end
              else
                "Sorry but <strong>#{@word.upcase}</strong> can't be build out of #{@grid}".html_safe
              end
  end

  private

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
