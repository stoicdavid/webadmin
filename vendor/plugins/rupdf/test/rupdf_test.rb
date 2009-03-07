require 'rubygems'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/rupdf'
require File.dirname(__FILE__) + '/../examples/simple'


class RupdfTest < Test::Unit::TestCase
  
  def test_generate
    report = Simple.new
    pdf = Rupdf::Renderer.render_pdf do |o|
      o.report_title = 'This is a test of a var being passed.'
    end
  end
  
end
