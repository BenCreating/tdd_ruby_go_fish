require_relative 'go_fish_game'

game = GoFishGame.new
game.start
until game.winner do
  puts game.play_round
end
puts "#{game.winner.name} wins!"
