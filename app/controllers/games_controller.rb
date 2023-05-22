require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    charset = Array("A".."Z")
    @letters = (0..10).map { charset.to_a[rand(charset.size)] }
  end

  def score
    @attempt = params[:word]
    validate_word(@attempt)
  end

  def validate_word(attempt)
    # Check if attempt is an English word by comparing it with the dictionary
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    serial = URI.open(url).read
    dictionary = JSON.parse(serial)

    return dictionary["found"]
  end

  def validate_grid(attempt, grid)
    # Check that every letter in your word appears in the grid
    attempt_chars = attempt.upcase.chars

    grid.each do |char|
      attempt_chars.delete_at(attempt_chars.index(char)) if attempt_chars.include?(char)
    end
    return attempt_chars == [] # this is returning attempt_arr if its empty
  end
end
