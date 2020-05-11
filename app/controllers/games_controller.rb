require 'json'
require 'open-uri'


class GamesController < ApplicationController
  def new
    @letters = []
    alphabets = ("a".."z").to_a
    10.times do
      @letters << alphabets.sample
    end
    @letters
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    serialized_words = open(url).read
    words = JSON.parse(serialized_words)

    if countGrid? && words['found']
      @message = "Congratulations! #{params[:word]} is a valid English word!"
    elsif countGrid? == true && words['found'] == false
      @message = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      @message = "Sorry but #{params[:word]} can't be built of #{params[:letters]} "
    end
  end



  private

  def countGrid?
    all_letters = params[:letters].split
    n = 0
    params[:word].split('').each do |letter|
      if all_letters.include?(letter)
        all_letters.delete(letter)
        n += 1
      end
    end
    return n == params[:word].length
  end

  # def originalGrid?
  #   each_letter = params[:word].split
  #   p @letters
  #   after_check = each_letter.select do |letter|
  #     @letters.include?(letter)
  #   end
  #   return each_letter.length == after_check.length
  # end
  # aabbccd
  # abdd
  # a - aabbccd n += 1
  # b - abbccd n += 1
  # d - abccd n += 1
  # d - abcc n += 0
end


