require_relative 'game_object'

class Hero < GameObject
  def initialize(game:, x:, y:, stationary: false, type: :player)
    @last_jump = nil
    @jump_delay = 0.5
    @jump_sound = Sound.new("jump_01.wav")
    super(game: game, x: x, y: y, stationary: stationary, type: type)
  end

  def create_sprite(x:, y:)
    Sprite.new(
      "hero.png",
      width: 25,
      height: 45,
      clip_width: 78,
      time: 250,
      x: x,
      y: y,
      animations: {
        stand: 1..1,
        walk: 1..2,
        climb: 3..4,
        cheer: 5..6,
      },
    )
  end

  def stand
    @x_speed = 0
    @sprite.play animation: :stand
  end

  def jump
    if @last_jump.nil? || Time.now - @last_jump > @jump_delay
      @sprite.play animation: :cheer, loop: true, flip: :horizontal
      @jump_sound.play
      @last_jump = Time.now
      @y_speed += -40
    end
  end

  def walk_left
    @x_speed = -10
    @sprite.play animation: :walk, loop: true, flip: :horizontal
  end

  def walk_right
    @x_speed = 10
    @sprite.play animation: :walk, loop: true
  end
end