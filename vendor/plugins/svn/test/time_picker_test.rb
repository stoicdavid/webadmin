require 'test/unit'
require 'rubygems'

require File.dirname(__FILE__) + '/../lib/time_picker'
require 'action_view/helpers/date_helper'

class TimePickerTest < Test::Unit::TestCase
  
  include ActionView::Helpers::DateHelper
  include TimePicker
  
  def test_time_picker_simple
    now = Time.now
    output = time_picker now, {:time_separator => ':', :minute_step => 60}
    output = output.gsub(/(\s)(?=[^>]*<)/, '').strip  #take out spaces and newlines
    assert_equal '<select id="date_hour_minute" name="date[hour_minute]"><option value="00:00">00:00</option><option value="01:00">01:00</option><option value="02:00">02:00</option><option value="03:00">03:00</option><option value="04:00">04:00</option><option value="05:00">05:00</option><option value="06:00">06:00</option><option value="07:00">07:00</option><option value="08:00">08:00</option><option value="09:00">09:00</option><option value="10:00">10:00</option><option value="11:00">11:00</option><option value="12:00">12:00</option><option value="13:00">13:00</option><option value="14:00">14:00</option><option value="15:00">15:00</option><option value="16:00">16:00</option><option value="17:00">17:00</option><option value="18:00">18:00</option><option value="19:00">19:00</option><option value="20:00">20:00</option><option value="21:00">21:00</option><option value="22:00">22:00</option><option value="23:00">23:00</option></select>', output
  end
  
  def test_time_picker_in_12_hour_format
    now = Time.now
    output = time_picker now, {:time_separator => ':', :time_format => '12', :minute_step => 60}
    output = output.gsub(/(\s)(?=[^>]*<)/, '').strip  #take out spaces and newlines
    assert_equal '<select id="date_hour_minute" name="date[hour_minute]"><option value="00:00">00:00AM</option><option value="01:00">01:00AM</option><option value="02:00">02:00AM</option><option value="03:00">03:00AM</option><option value="04:00">04:00AM</option><option value="05:00">05:00AM</option><option value="06:00">06:00AM</option><option value="07:00">07:00AM</option><option value="08:00">08:00AM</option><option value="09:00">09:00AM</option><option value="10:00">10:00AM</option><option value="11:00">11:00AM</option><option value="12:00">12:00PM</option><option value="13:00">01:00PM</option><option value="14:00">02:00PM</option><option value="15:00">03:00PM</option><option value="16:00">04:00PM</option><option value="17:00">05:00PM</option><option value="18:00">06:00PM</option><option value="19:00">07:00PM</option><option value="20:00">08:00PM</option><option value="21:00">09:00PM</option><option value="22:00">10:00PM</option><option value="23:00">11:00PM</option></select>', output
  end
  
end
