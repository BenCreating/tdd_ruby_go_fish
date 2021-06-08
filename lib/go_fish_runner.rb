require_relative 'go_fish_game'

game = GoFishGame.new
game.start
until game.winners do
  puts game.next_turn
end
puts "#{game.winners} wins!"
