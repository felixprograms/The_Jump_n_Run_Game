# .Inside Level..Each Space is 50 pixels.Wide.
require "ruby2d"
require "byebug"
set width: 1200, height: 500

class Player
  attr_accessor :x_speed, :y_speed, :x, :y, :sprite

  def initialize(x, y)
    @x_speed = 0
    @y_speed = 0
    @x = 0
    @y = 0
    @sprite = Sprite.new(
      "hero.png",
      width: 39,
      height: 50,
      clip_width: 78,
      time: 250,
      x: x,
      y: y,
      animations: {
        walk: 1..2,
        climb: 3..4,
        cheer: 5..6,
      },
    )
  end

  def move
    @x += @x_speed
    if @y_speed <= 3
      @y_speed += $gravity
    end

    if (@y + @y_speed) >= $floor.y && (@y + @y_speed) <= ($floor.y + $floor.height)
      @y_speed = 0
      $double_jumped_alllllowed = 2
      @y = $floor.y
    else
      @y += @y_speed
    end

    @sprite.x = @x
    @sprite.y = @y
  end
end

def create_sound
  jump = Sound.new("jump_01.wav")
  jump.play
end

# coin = Sprite.new(
#   'coin.png',
#   clip_width: 84,
#   time: 300,
#   loop: true
# )
# coin.play

def create_block(x, y)
  $floor = Rectangle.new(
    x: x, y: y,
    width: 50, height: 50,
    color: "red",
  )
end

def create_player(x, y)
  @player = Player.new(x, y)
end

File.open("Level_1") do |f|
  y = 0
  f.each_line do |line|
    x = 0
    line.split("").each do |character|
      if character == "="
        create_block(x * 50, y * 50)
      elsif character == "0"
        create_player(x * 50, y * 50)
      end
      x += 1
    end
    y += 1
  end
end

@x_speed = 0
@y_speed = 0
$gravity = 0.5
$double_jumped_alllllowed = 2
@last_jumped = nil

on :key_down do |event|
  case event.key
  when "left"
    @player.sprite.play animation: :walk, loop: true, flip: :horizontal
  when "right"
    @player.sprite.play animation: :walk, loop: true
  end
end

on :key do |event|
  if event.key == "right" && event.type == :held
    @player.x_speed = 8
  elsif event.key == "right" && event.type == :up
    @player.x_speed = 0
  end
  if event.key == "left" && event.type == :held
    @player.x_speed = -8
  elsif event.key == "left" && event.type == :up
    @player.x_speed = 0
  end
  if event.key == "up" && event.type == :down && $double_jumped_alllllowed > 0 && (@last_jumped.nil? || @last_jumped - Time.now.to_f <= 0.5)
    @player.y_speed = -15
    $double_jumped_alllllowed -= 1
    @last_jumped = Time.now.to_f
    create_sound
  elsif event.key == "up" && event.type == :up
    @player.y_speed = 0
  end
end
update do
  @player.move
end
show
