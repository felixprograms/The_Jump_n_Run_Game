class GenerateLevel
  def should_load?
    if @coins_collected < 10
      @should_load_new_level = false
    else
      @should_load_new_level = true
    end
  end
  def load_level_1
    File.foreach("Level_1").each_with_index do |line, y|
      line.split("").each_with_index do |character, x|
        if character == "="
          @floor_tiles << Tile.new(game: self, x: x * 50, y: y * 50)
        elsif character == "M"
          @floor_tiles << MovingTile.new(game: self, x: x * 50, y: y * 50, stationary: true, x_speed: 1.0)
        elsif character == "R"
          @floor_tiles << MovingTile.new(game: self, x: x * 50, y: y * 50, stationary: true, x_speed: -1.0)
        elsif character == "C"
          @coins << Coin.new(game: self, x: x * 50, y: y * 50)
        elsif character == "H"
          @player = Hero.new(game: self, x: x * 50, y: y * 50)
          @starting_coordinates = [x * 50, y * 50]
        end
      end
    end
  end
  def load_level_2
    File.foreach("Level_2").each_with_index do |line, y|
      line.split("").each_with_index do |character, x|
        if character == "="
          @floor_tiles << Tile.new(game: self, x: x * 50, y: y * 50)
        elsif character == "M"
          @floor_tiles << MovingTile.new(game: self, x: x * 50, y: y * 50, stationary: true, x_speed: 1.0)
        elsif character == "R"
          @floor_tiles << MovingTile.new(game: self, x: x * 50, y: y * 50, stationary: true, x_speed: -1.0)
        elsif character == "C"
          @coins << Coin.new(game: self, x: x * 50, y: y * 50)
        elsif character == "H"
          @player = Hero.new(game: self, x: x * 50, y: y * 50)
          @starting_coordinates = [x * 50, y * 50]
        end
      end
    end
  end
      
end

