class Hangman

def initialize()
  @word = random_word("word_list.txt")
end

def random_word(file)
  words = File.read(file).split
  filtered_words = words.select{ |word| word.length >= 5 && word.length <= 12}
  filtered_words.sample
end

def get_word()
  "#{@word}"
end

def play_game()
  count = 7
  word = get_word()
  underscores = underscore_array()
  guess_array = Array.new
  print "Word: " + underscores.join
  while count > 0  # Keep playing as long as there are guesses left
    print "You have #{count} guesses left."


    letter = guess()  # Get a guess from the user

    if check_guess?(underscores, word, letter, count, guess_array)
      count +=1
    end
    if win?(underscores)
      puts "Congratulations! You've guessed the word!"
      break  # Exit the loop if the user wins
    end
    count -= 1
    if count == 0
      puts "Sorry, you're out of guesses. The word was '#{word}'. You lost!"
    end
  end
end

def guess()
  loop do
    puts " Please enter your guess (a single letter):"
    input = gets.chomp.downcase  # Convert the input to lowercase immediately

    # Check if the input is exactly one character and it's a letter
    if input.length == 1 && input.match?(/[a-zA-Z]/)
      return input  # Return the valid guess
    else
      puts "Invalid input. Please enter a single letter."
    end
  end
end

def check_guess?(underscores, word, letter, count, guess_array)
  word_array = word.chars 
  flag = false
  # Check each character of the word and replace the underscore with the letter if the guess is correct
  word_array.each_with_index do |char, index|
    if char == letter
      underscores[index] = "#{char} "  # Replace the underscore with the correct letter 
      flag = true
    end
  end
  unless flag
    unless guess_array.include?(letter)
    guess_array.push(letter)
    end
  end
  
  if win?(underscores)
    puts "You win!"
    
  else
  # Print the current state of the word with underscores
  count -=1
  puts underscores.join
  print "Incorrect guesses: " + guess_array.join
  end
  return flag
end

def underscore_array
  underscore_array = Array.new("#{@word}".length, "_ ")
  return underscore_array
end
def win?(underscores)
  if underscores.none?("_ ")
    return "You win!"
  end
end

end