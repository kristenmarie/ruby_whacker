require 'gosu'

class WhackARuby < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Whack the Ruby!'
    @ruby = Gosu::Image.new('img/ruby.png')
    @hammer = Gosu::Image.new('img/hammer.png')
    @x = 200
    @y = 200
    @width = 50
    @height = 50
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hit = 0
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
      @ruby.draw(@x - @width/2, @y - @height / 2, 1)
    end
    @hammer.draw(mouse_x - 40, mouse_y - 10, 1)
    # Screen turns green when ruby is hit, red when its a miss.
    if @hit == 0
      c = Gosu::Color::NONE
    elsif @hit == 1
      c = Gosu::Color::GREEN
    elsif @hit == -1
      c = Gosu::Color::RED
    end
    draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
    @hit = 0
  end

  def button_down(id)
    if(id == Gosu::MsLeft)
      if Gosu.distance(mouse_x, mouse_y, @x, @y) < 50 && @visible >= 0
        @hit = 1
      else
        @hit = -1
      end
    end
  end
end
window = WhackARuby.new
window.show
