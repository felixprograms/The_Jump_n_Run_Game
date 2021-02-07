# .Inside Level..Each Space is 50 pixels.Wide.
require "byebug"
require 'ruby2d'
require_relative 'coin'
require_relative 'hero'
require_relative 'tile'
require_relative 'moving_tile'

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 450

set width: 800, height: 450

Image.new(
  'bg.png',
  x: 0, y: 0,
  width: 800, height: 450,
  z: -10
)
class Game
  attr_accessor :player, :floor_tiles, :starting_coordinates

  def initialize
    @player = nil
    @floor_tiles = []
    @starting_coordinates = nil
  end

  def run
    generate_level
  end

  def update_game_objects
    ([@player] + @floor_tiles).each(&:update_game_object)
  end

private

  def generate_level
    File.foreach("Level_1").each_with_index do |line, y|
      line.split("").each_with_index do |character, x|
        if character == "="
          @floor_tiles << Tile.new(game: self, x: x * 50, y: y * 50)
        elsif character == "M"
          @floor_tiles << MovingTile.new(game: self, x: x * 50, y: y * 50, stationary: true, x_speed: 1.0)
        elsif character == "R"
          @floor_tiles << MovingTile.new(game: self, x: x * 50, y: y * 50, stationary: true, x_speed: -1.0)
        elsif character == "C"
          @floor_tiles << Coin.new(game: self, x: x * 50, y: y * 50)
        elsif character == "H"
          @player = Hero.new(game: self, x: x * 50, y: y * 50)
          @starting_coordinates = [x * 50, y * 50]
        end
      end
    end
  end
end

game = Game.new
game.run

on :key_up do |event|
  game.player.stand
end

on :key_held do |event|
  case event.key
  when "left"
    game.player.walk_left
  when "right"
    game.player.walk_right
  end
end

on :key_down do |event|
  case event.key
  when "up"
    game.player.jump
  end
end

update do
  game.update_game_objects
end

show
