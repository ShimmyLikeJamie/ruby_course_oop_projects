def show_board(arr)
  i = 0
  while i < 3
    y = 0
    while y < 3
      print arr[i][y]
      y += 1
    end
    puts ""
    i += 1
  end
end

def mark_square(num, row)
  if row[num] == "O" || row[num] == "X"
    puts "Space already taken!"
    return true
  else
    if $player_one
      row[num] = "X"
      $player_one = false
    else
      row[num] = "O"
      $player_one = true
    end
    $moves_taken += 1
  end
  false
end

def check_for_win(arr)
  #Horizontal check
  if (arr[0][0] == "X" && arr[0][1] == "X" && arr[0][2] == "X") ||
      (arr[1][0] == "X" && arr[1][1] == "X" && arr[1][2] == "X") ||
      (arr[2][0] == "X" && arr[2][1] == "X" && arr[2][2] == "X")
      puts "Player one wins!"
      return true
  elsif (arr[0][0] == "O" && arr[0][1] == "O" && arr[0][2] == "O") ||
      (arr[1][0] == "O" && arr[1][1] == "O" && arr[1][2] == "O") ||
      (arr[2][0] == "O" && arr[2][1] == "O" && arr[2][2] == "O")
      puts "Player two wins!"
      return true
  elsif (arr[0][0] == "X" && arr[1][0] == "X" && arr[2][0] == "X") || #Vertical check
    (arr[0][1] == "X" && arr[1][1] == "X" && arr[2][1] == "X") ||
    ((arr[0][2] == "X" && arr[1][2] == "X" && arr[2][2] == "X"))
    puts "Player one wins!"
    return true
  elsif (arr[0][0] == "O" && arr[1][0] == "O" && arr[2][0] == "O") ||
    (arr[0][1] == "O" && arr[1][1] == "O" && arr[2][1] == "O") ||
    ((arr[0][2] == "O" && arr[1][2] == "O" && arr[2][2] == "O"))
    puts "Player two wins!"
    return true
  elsif (arr[0][0] == "X" && arr[1][1] == "X" && arr[2][2] == "X") || #Diagonal check
    (arr[0][2] == "X" && arr[1][1] == "X" && arr[2][0] == "X")
    puts "Player one wins!"
    return true
  elsif (arr[0][0] == "O" && arr[1][1] == "O" && arr[2][2] == "O") ||
    (arr[0][2] == "O" && arr[1][1] == "O" && arr[2][0] == "O")
    puts "Player two wins!"
    return true
  else
    return false
  end
end

top_row = ["7", "8", "9"]
middle_row = ["4", "5", "6"]
bottom_row = ["1", "2", "3"]
board = [top_row, middle_row, bottom_row]

$winner = false
$tie = false
$player_one = true
$moves_taken = 0

puts "Welcome to tic-tac-toe!"
puts "Player one goes first."

while $winner == false || $tie == false
  show_board(board)
  puts "Enter 1-9 to select a square: "
  user_input = gets.chomp
  case user_input
  when "1"
    error_flag = mark_square(0, bottom_row)
  when "2"
    error_flag = mark_square(1, bottom_row)
  when "3"
    error_flag = mark_square(2, bottom_row)
  when "4"
    error_flag = mark_square(0, middle_row)
  when "5"
    error_flag = mark_square(1, middle_row)
  when "6"
    error_flag = mark_square(2, middle_row)
  when "7"
    error_flag = mark_square(0, top_row)
  when "8"
    error_flag = mark_square(1, top_row)
  when "9"
    error_flag = mark_square(2, top_row)
  else
    "Invalid input!"
    redo
  end
  
  if error_flag == true
    puts "Invalid move detected!"
    error_flag = false
    redo
  elsif check_for_win(board)
    $winner = true
    puts "Ending game"
    show_board(board)
    exit
  else
    puts "No winner"
    if $moves_taken == 9
      puts "The game ends in a tie!"
      $tie = true
      show_board(board)
      exit
    else
      puts "The game continues"
    end
  end
end