require 'yaml'
require 'pry'

class Hangman
  attr_accessor :word, :underscores, :count, :guess_array

def initialize(word = nil, underscores = nil, count = 7, guess_array = [])
  @word = word || random_word("word_list.txt")   # Use the word from the saved state, or pick a random word
  @underscores = underscores || underscore_array()   # Use underscores from the saved state or generate new ones
  @count = count
  @guess_array = guess_array
end

def to_yaml
  YAML.dump ({
    :word => @word, 
    :underscores => @underscores, 
    :count => @count, 
    :guess_array => @guess_array
  })
end
def self.from_yaml(string)
  data = YAML.load string
  p data
  self.new(data[:word],data[:underscores],data[:count],data[:guess_array])
end

def save_to_file(file_name)
  File.write(file_name, self.to_yaml)  # Correctly specify both the file path and the content to write
  puts "Game saved!"
end

def self.load_from_file(file_name)
  file_contents = File.read(file_name)  # Read the YAML string from the file
  from_yaml(file_contents)  # Call the from_yaml method to convert string to object
end

def random_word(file)
  words = File.read(file).split
  filtered_words = words.select{ |word| word.length >= 5 && word.length <= 12}
  filtered_words.sample
end

def underscore_array
  underscore_array = Array.new(@word.length, "_ ")
  return underscore_array
end

def get_word()
  @word
end



def guess()
  loop do
    puts " Please enter your guess (a single letter):"
    @letter = gets.chomp.downcase  # Convert the input to lowercase immediately

    # Check if the input is exactly one character and it's a letter
    if @letter.length == 1 && @letter.match?(/[a-zA-Z]/)
      return @letter  # Return the valid guess
    else
      puts "Invalid input. Please enter a single letter."
    end
  end
end

def check_guess?()
  word_array = word.chars 
  flag = false
  # Check each character of the word and replace the underscore with the letter if the guess is correct
  word_array.each_with_index do |char, index|
    if char == @letter
      @underscores[index] = "#{char} "  # Replace the underscore with the correct letter 
      flag = true
    end
  end
  unless flag
    unless @guess_array.include?(@letter)
    @guess_array.push(@letter)
    end
  end
  
  if win?()
    puts "You win!"
    
  else
  # Print the current state of the word with underscores
  puts @underscores.join
  print "Incorrect guesses: " + @guess_array.join(', ') +" "
  end
  return flag
end


def win?()
  if @underscores.none?("_ ")
    return "You win!"
  end
end





end