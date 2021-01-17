require 'ruby2d'

set width: 1200, height: 500

@player = Rectangle.new(
  x: 600, y: 50,
  width: 15, height: -15,
  color: 'yellow'
)
@floor = Rectangle.new(
  x: 0, y: 300,
  width: 1200, height: 30,
  color: 'red'
)
@x_speed = 0
@y_speed = 0
@gravity = 0.5
@double_jumped_alllllowed = 2
@last_jumped = nil
update do
    @player.x += @x_speed
    if @y_speed <= 3
        @y_speed += @gravity
    end

    if ( @player.y + @y_speed ) >= @floor.y  && ( @player.y + @y_speed ) <= (@floor.y + @floor.height)
        @y_speed = 0
        @double_jumped_alllllowed = 2
        @player.y = @floor.y
    else
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
    if event.key == 'up' && event.type == :down && @double_jumped_alllllowed > 0 && (@last_jumped.nil? || @last_jumped - Time.now.to_f <= 0.5)
        @y_speed = -15
        @double_jumped_alllllowed -= 1
        @last_jumped = Time.now.to_f
    elsif event.key == 'up' && event.type == :up
        @y_speed = 0
    end

end
show