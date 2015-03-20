require 'gtk2'
require '../Models/game.rb'
require '../Controllers/player_controller.rb'
class Gameview < Gtk::Builder
  attr_accessor :game, :control
  def initialize()
    @game = Game.instance
    @game.newGame('otto')
    @control = PlayerController.instance
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
          @control.makeMove(col)
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

  #next 3 are button handlers for game setup
  def start()
    #TODO
  end
  
  def gametype()
    #TODO
  end
  
  def difficulty()
    #TODO
  end
  
  #this is button handler for player
  def player(col)
    #TODO
  end
  
  #this makes the computer move
  def comp()
    #TODO
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
          @control.makeMove(col)
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
  builder = createGUI('main.glade')
  Gtk.main
end