require 'gtk2'

class Builder < Gtk::Builder
  @player = 'red'
  def initialize xml
    boo = 'empty'
    super()
    self.add_from_file(xml)
    self['main'].set_window_position Gtk::Window::POS_CENTER
    self['main'].signal_connect('destroy') { Gtk.main_quit }
    row=0
    col=0
    7.times do |col|
      6.times do |row|
        p "\n cxr: #{col.to_s}x#{row.to_s}"
        image = Gtk::Image.new("#{boo}.png")
        button = Gtk::Button.new
        button.set_image(image)
        button.signal_connect("clicked") {
          p "click #{col.to_s}.#{row.to_s}"
          image = Gtk::Image.new("#{getPlayer}.png")
          button.set_image(image)
        }
        self['boardGrid'].attach button, col,col+1,row,row+1
      end
    end
    self['boardGrid'].show
    self['main'].show_all
  end

  def on_button_clicked w
    case w.label
      when 'quit'
        Gtk::main_quit
      else
        puts "# on_button_clicked : " + w.label

    end
  end

  def on_main_destroy
    puts "# on_main_destroy"
    Gtk::main_quit
  end

  def getPlayer
    if @player == 'red'
      @player='blue'
    else
      @player='red'
    end
    @player
  end

end
if __FILE__ == $0
  xml = 'main.glade'
  Gtk.init
  builder = Builder.new(xml)
  Gtk.main
end
