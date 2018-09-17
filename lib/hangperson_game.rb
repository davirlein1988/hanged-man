class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  attr_accessor(:word, :guesses,:wrong_guesses) 
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  

  def guess(guess)
    raise ArgumentError if guess == nil
    raise ArgumentError if guess.empty?  
    raise ArgumentError if ((guess =~ /[\w]/i)== nil)  
    
    guess.downcase!
    if @word.include? guess and !@guesses.include? guess
      @guesses << guess
      return true
    elsif !@word.include? guess and !@wrong_guesses.include? guess
      @wrong_guesses << guess
      return true
    else
      return false
    end

    
  end

  def word_with_guesses
    displayed = ""
    @word.chars.each do |i|
      if @guesses.include? i
        displayed << i
        else
          displayed << "-"
        end
      end
      return displayed
     
  end


  def check_win_or_lose
    count = 0
    return :lose if @wrong_guesses.length >= 7

    @word.each_char do |l|
      count += 1 if @guesses.include? l 
    end
    if count == @word.length then :win
    else :play 
    end
  end

  

end
