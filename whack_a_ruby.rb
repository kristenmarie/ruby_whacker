require 'gosu'

class WhackARuby < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Whack the Ruby!'
    @image = Gosu::Image.new('ruby.png')
    @x = 200
    @y = 200
    @width = 50
    @height = 50
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
  end

  # Update means animate!
  def update
    @x += @velocity_x
    @y += @velocity_y
    # When the ruby hits edge of game window
    if @x + @width / 2 > 800 || @x - @width / 2 < 0
      @velocity_x *= -1
    end
    if @y + @height / 2 > 600 || @y - @height / 2 < 0
      @velocity_y *= -1
    end
    # Decrease visible once each frame
    @visible -= 1
    # Random chance visible can be visible for 30 frames.
    if @visible < -10 && rand < 0.01
      @visible = 30
    end
  end

  def draw
    # Only show ruby when visible is positive.
    if @visible > 0
      @image.draw(@x - @width/2, @y - @height / 2, 1)
    end
  end

end
window = WhackARuby.new
window.show
