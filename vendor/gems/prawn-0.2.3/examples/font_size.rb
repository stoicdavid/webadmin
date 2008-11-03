# encoding: utf-8

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require "prawn"

Prawn::Document.generate "font_size.pdf", :page_size => "A4" do
  font 'Helvetica'
  font.size = 16
  
  text 'Font at 16 point'
  
  font.size 9 do
    text 'Font at 9 point'
    text 'Font at manual override 20 point', :size => 20
    text 'Font at 9 point'
  end
  
  text 'Font at 16 point'
end
