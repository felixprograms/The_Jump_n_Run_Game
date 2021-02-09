class GameObject
  attr_accessor :x_speed, :y_speed, :sprite, :game
  GRAVITY = 5

  def initialize(game:, x:, y:, type: nil, stationary: true)
    @stationary = stationary
    @game = game
    @x_speed = 0.0
    @y_speed = 0.0
    @sprite = create_sprite(x: x, y: y)
    @type = type
    @sprite.play
  end

  def update_game_object
    if @type == :player
      @game.floor_tiles.each do |floor_tile|
        if next_x_overlap?(floor_tile) && current_y_overlap?(floor_tile)
          if right(true) > floor_tile.left && left < floor_tile.left
            @sprite.x = floor_tile.left - @sprite.width
          elsif left(true) < floor_tile.right && right > floor_tile.right
            @sprite.x = floor_tile.right
          end
          @x_speed = 0
        end

        if next_y_overlap?(floor_tile) && current_x_overlap?(floor_tile)
          if bottom(true) > floor_tile.top && top < floor_tile.top
            @sprite.y = floor_tile.top - @sprite.height
          elsif top(true) < floor_tile.bottom && bottom > floor_tile.bottom
            @sprite.y = floor_tile.bottom
          end
          @y_speed = 0
        end
      end

      if @sprite.y > WINDOW_HEIGHT
        @sprite.x, @sprite.y = @game.starting_coordinates
        @x_speed, @y_speed = 0, 0
      end

      @game.coins.each do |coin|
        if (next_x_overlap?(coin) && current_y_overlap?(coin)) || (next_y_overlap?(coin) && current_x_overlap?(coin))
          coin.sprite.remove
          @game.coins -= [coin]
          @game.no_of_coins_left -= 1
        end
      end

      @sprite.x = @sprite.x % WINDOW_WIDTH
    end


    @sprite.x += @x_speed
    @sprite.y += @y_speed

    @y_speed += GRAVITY unless @stationary
    @y_speed = 10 if @y_speed > 10

    if @game.no_of_coins_left < 1
      @game.generate_next_level
    end
  end

  def left(with_speed_offset = false)
    @sprite.x + (with_speed_offset ? @x_speed : 0)
  end

  def right(with_speed_offset = false)
    @sprite.x + @sprite.width + (with_speed_offset ? @x_speed : 0)
  end

  def top(with_speed_offset = false)
    @sprite.y + (with_speed_offset ? @y_speed : 0)
  end

  def bottom(with_speed_offset = false)
    @sprite.y + @sprite.height + (with_speed_offset ? @y_speed : 0)
  end

  private

  def current_x_overlap?(other_object, with_speed_offset = false)
    left(with_speed_offset) < other_object.right && other_object.left < right(with_speed_offset)
  end

  def current_y_overlap?(other_object, with_speed_offset = false)
    top(with_speed_offset) < other_object.bottom && other_object.top < bottom(with_speed_offset)
  end

  def next_x_overlap?(other_object)
    current_x_overlap?(other_object, true)
  end

  def next_y_overlap?(other_object)
    current_y_overlap?(other_object, true)
  end

  def create_sprite
    raise 'You must set a sprite in your descendant game object'
  end
end