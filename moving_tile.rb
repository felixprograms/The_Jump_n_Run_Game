require_relative 'tile'

class MovingTile < Tile
  def initialize(game:, x:, y:, stationary: true, type: :moving_tile, x_speed: 1.0, y_speed: 0.0)
    super(game: game, x: x, y: y, stationary: stationary, type: type)
    @x_speed = x_speed
    @y_speed = y_speed
  end

  def create_sprite(x:, y:)
    @x_anchor = x
    @y_anchor = y
    @x_speed = 2
    Sprite.new(
      "ground.png",
      width: 50,
      height: 50,
      x: x,
      y: y
    )
  end

  def update_game_object
    super
    move_in_place
  end

  def move_in_place
    if @sprite.x > @x_anchor + @sprite.width * 1.5
      @x_speed *= -1
    elsif @sprite.x < @x_anchor - @sprite.width * 1.5
      @x_speed *= -1
    end
    @sprite.x += @x_speed
  end
end