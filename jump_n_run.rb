require 'ruby2d'

set width: 1200, height: 500

@player = Rectangle.new(
  x: 600, y: 250,
  width: 15, height: 15,
  color: 'yellow'
)
@floor = Rectangle.new(
  x: 0, y: 300,
  width: 1200, height: 2,
  color: 'red'
)
@x_speed = 0
@y_speed = 0
@gravity = 10

def collided?
    if @player.y >= @floor.y - 24
        true
    else
        @player.y = @floor.y - 24
        false
    end
end

update do
    @player.x += @x_speed
    if @y_speed < @gravity
        @y_speed += @gravity
    end
    unless collided?
        @player.y += @y_speed
    end
end

on :key do |event|
    if event.key == 'right' && event.type == :held
        @x_speed = 8
    elsif event.key == 'right' && event.type == :up
        @x_speed = 0
    end
    if event.key == 'left' && event.type == :held
        @x_speed = -8
    elsif event.key == 'left' && event.type == :up
        @x_speed = 0
    end
    if event.key == 'up' && event.type == :held
        @player.y -= 30
    end
end
show