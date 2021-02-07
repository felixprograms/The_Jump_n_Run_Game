require_relative 'game_object'

class Tile < GameObject
  def create_sprite(x:, y:)
    Sprite.new(
      "ground.png",
      width: 50,
      height: 50,
      x: x,
      y: y
    )
  end
end