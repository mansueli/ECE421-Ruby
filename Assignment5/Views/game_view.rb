require 'gtk2'
require '../Models/game.rb'
require '../Models/player.rb'
require '../Controllers/player_controller.rb'

class Gameview < Gtk::Builder
  attr_accessor :game, :control1, :control2
  def initialize(xml)
    @xml = xml
    @game = Game.instance
    @player1 = Player.new()  #set the players from GUI
    @player2 = Player.new()

    @player1.type = 'human'
    @player2.type = 'bot_hard'

    @game.newGame('d', self, @player1, @player2)

    @control1 = PlayerController.new(@game, @player1)
    @control2 = PlayerController.new(@game, @player2)

    super()
  end

  def createGUI()
   
    self.add_from_file(@xml)
    self['main'].set_window_position Gtk::Window::POS_CENTER
    self['main'].signal_connect('destroy') { Gtk.main_quit }
    7.times do |col|
      6.times do |row|
        #p "\n cxr: #{col.to_s}x#{row.to_s}"
        image = Gtk::Image.new("#{@game.state[row,col].type}.png")
        button = Gtk::Button.new
        button.set_image(image)
        button.signal_connect("clicked") {
          #puts @control1.player.type
          if (!@control1.makeMove(col))
            @control2.makeMove(col)
          end
          p "click #{col.to_s}.#{row.to_s}"
          image = Gtk::Image.new("#{@game.state[row,col].type}.png")
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
    createGUI()
  end
end

if __FILE__ == $0

  Gtk.init
  xml = 'main.glade'
  v = Gameview.new(xml)
  builder = v.createGUI()
  Gtk.main
end
