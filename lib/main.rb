require_relative 'hangman'

def load_game
  if File.exist?('saved_game.yml')
    puts 'Do you want to load the saved game? (y/n)'
    choice = gets.chomp.downcase
    if choice == 'y'
      game = Hangman.load_from_file('saved_game.yml')
      play_game(game)
    else
      game = Hangman.new
      play_game(game)
    end
  else
    game = Hangman.new
      play_game(game)
end
end


def play_game(game)
  print "Word: " + game.underscores.join
  while game.count > 0  # Keep playing as long as there are guesses left
    print "\nYou have #{game.count} guesses left. "
    puts "Would you like to (1) Guess a letter or (2) Save the game?"
    choice = gets.chomp.to_i

    case choice
    when 1
      
    game.guess()
    game.count -=1

    if game.check_guess?()
      game.count +=1
    end
    if game.win?()
      puts "Congratulations! You've guessed the word!"
      break  # Exit the loop if the user wins
    end
    if game.count == 0
      puts "Sorry, you're out of guesses. The word was '#{word}'. You lost!"
      break
    end
  when 2
    game.save_to_file('saved_game.yml')  # Save the current game state to a file
      break  # Exit the loop after saving the game
    else
      puts "Invalid option, please choose (1) to guess or (2) to save the game."
    end
  end
end

load_game