require "colorize"

def select_prompt
  puts "1 = " + "red".red
  puts "2 = " + "cyan".cyan
  puts "3 = " + "yellow".yellow
  puts "4 = " + "green".green
  puts "5 = " + "blue".blue
  puts "6 = " + "purple".magenta
  puts "You have #{12 - $turns} turns left."
  puts "Select a combination of 4 pegs! (1111 - 6666)."
end

def human_selects?
  puts "Do you want to choose the secret combination? y/n"

  loop do
    human_picks = gets.chomp
    if human_picks.downcase == "y"
      return true
    elsif human_picks.downcase == "n"
      return false
    else 
      puts "Invalid input! Try again."
    end
  end
end

def correct_positions(answer, input_as_array)
  result = 0
  i = 0
  while i < 4
    if input_as_array[i] == answer[i]
      result += 1
    end
    i += 1
  end
  result
end

def correct_colors(answer, input_as_array)
  result = 0
  matched = []

  input_as_array.each do |x|
    if answer.include? x
      if matched.include? x
        next
      else
        result += 1
        matched.push(x)
      end
    end
  end
  result
end

def human_selects
  answer = ""

  loop do
    puts "Enter your 4 colored pegs: "
    pegs = gets.chomp
    if pegs.to_i < 1111 || pegs.to_i > 6666
      puts "Invalid input! Try again."
      redo
    else
      answer = pegs
      break
    end
  end
  return answer
end

def computer_vs_you
  answer = human_selects
  turns = 0

  while turns < 12
    puts "I am going to take a turn"
    guess = computer_takes_turn.join("")
    # turns += 1
    puts "My guess is #{guess}"
    if guess == answer
      puts "I win! Exiting game"
      exit
    else
      puts "I will try again"
    end
  end
end

def computer_takes_turn
  guess = []
  4.times do 
    guess.push(rand(1..6).to_s)
  end
  return guess
end

def you_vs_computer

  answer = []
  4.times do
    answer.push(rand(1..6).to_s)
  end
  turns = 0
  solved = false
  
  puts "Welcome to the mastermind game."
  puts "The goal of the game is to guess the 4 colored pegs within 12 tries."

  puts "The computer is thinking of 4 colored pegs in 4 spots."
  while solved == false
    select_prompt
    input_as_string = gets.chomp
    input_as_array = input_as_string.split("")

    puts "You entered #{input_as_string}"
    puts "*DEVELOPMENT PURPOSES* The answer is: #{answer}"

    if input_as_string.length > 4 || (input_as_string.to_i < 1111 || input_as_string.to_i > 6666)
      puts "Input error!"
      redo
    else
      if input_as_string == answer.join("").to_s
        puts "Correct guess!"
        solved = true
      else
        puts "The number of correct colors is: #{correct_colors(answer, input_as_array)}"
        puts "The number of colors in the correct position is: #{correct_positions(answer, input_as_array)}"
      end
    end

    turns += 1

    if turns >= 12
      puts "You have reached the maximum number of turns, exiting game"
      exit
    end
  end  
end

if human_selects?
  computer_vs_you
else
  you_vs_computer
end
