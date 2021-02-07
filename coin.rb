require_relative 'game_object'

class Coin < GameObject
  def create_sprite(x:, y:)
    Sprite.new(
      'coin.png',
      clip_width: 84,
      width: 50,
      height: 50,
      x: x,
      y: y,
      time: 300,
      loop: true
    )
  end
end