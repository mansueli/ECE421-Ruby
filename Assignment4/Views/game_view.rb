require 'gtk2'
require '../Models/game.rb'
require '../Models/player.rb'
require '../Controllers/player_controller.rb'

class Gameview < Gtk::Builder
  attr_accessor :game, :control1, :control2
  def initialize()
    @game = Game.instance
    @player1 = Player.new()  #set the players from GUI
    @player2 = Player.new()
    @game.newGame('otto', self, @player1, @player2)
    @control1 = PlayerController.new(@game, @player1)
    @control2 = PlayerController.new(@game, @player2)
  end

  def createGUI(xml)
    super()
    self.add_from_file(xml)
    self['main'].set_window_position Gtk::Window::POS_CENTER
    self['main'].signal_connect('destroy') { Gtk.main_quit }
    7.times do |col|
      6.times do |row|
        p "\n cxr: #{col.to_s}x#{row.to_s}"
        image = Gtk::Image.new("#{@game.state[col,row].type}.png")
        button = Gtk::Button.new
        button.set_image(image)
        button.signal_connect("clicked") {
          if (!@control1.makeMove(col))
            @control2.makeMove(col)
          end
          p "click #{col.to_s}.#{row.to_s}"
          image = Gtk::Image.new("#{@game.state[col,row].type}.png")
          button.set_image(image)
        }
        self['boardGrid'].attach button, col,col+1,row,row+1
      end
    end
    self['boardGrid'].show
    self['main'].show_all
  end

  #this redisplays the board after a move
  def update()
    self['boardGrid'] = Gtk::Table.new()
    7.times do |col|
      6.times do |row|
        p "\n cxr: #{col.to_s}x#{row.to_s}"
        image = Gtk::Image.new("#{@game.state[col,row].type}.png")
        button = Gtk::Button.new
        button.set_image(image)
        button.signal_connect("clicked") {
          if (!@control1.makeMove(col))
            @control2.makeMove(col)
          end
          p "click #{col.to_s}.#{row.to_s}"
          image = Gtk::Image.new("#{@game.state[col,row].type}.png")
          button.set_image(image)
        }
        self['boardGrid'].attach button, col,col+1,row,row+1
      end
    end
  end
end

if __FILE__ == $0

  Gtk.init
  xml = 'main.glade'
  v = Gameview.new()
  builder = v.createGUI('main.glade')
  Gtk.main
end
