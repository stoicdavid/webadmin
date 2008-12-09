# TimePicker
module TimePicker
  def time_picker(datetime = Time.now, options = {})
    separator = options[:time_separator] || ''
    select_hours_minutes(datetime, options)
  end
  
  def select_hours_minutes(datetime, options = {})
    separator = options[:time_separator] || ''
    val_hour = datetime ? (datetime.kind_of?(Fixnum) ? datetime : datetime.hour) : ''
    val_minute = datetime ? (datetime.kind_of?(Fixnum) ? datetime : datetime.min) : ''
    if options[:use_hidden]
      hidden_html(options[:field_name] || 'hour', val_hour, options)
    else
      hour_minute_options = []
      unless options[:time_format] == '12'
        0.upto(23) do |hour|
          0.step(59, options[:minute_step] || 1) do |minute|
            unless (val_hour == hour) && (val_minute == minute)
              hour_minute_options << (%(<option value="#{leading_zero_on_single_digits(hour)}#{separator}#{leading_zero_on_single_digits(minute)}">#{leading_zero_on_single_digits(hour)}#{separator}#{leading_zero_on_single_digits(minute)}</option>\n))
            else
              hour_minute_options << (%(<option value="#{leading_zero_on_single_digits(hour)}#{separator}#{leading_zero_on_single_digits(minute)}" selected="selected">#{leading_zero_on_single_digits(hour)}#{separator}#{leading_zero_on_single_digits(minute)}</option>\n))
            end
          end
        end
      else
        0.upto(23) do |hour|
          period = 'AM'
          period = 'PM' if hour >= 12
          0.step(59, options[:minute_step] || 1) do |minute|
            unless (val_hour == hour) && (val_minute == minute)
              hour_minute_options << (%(<option value="#{leading_zero_on_single_digits(hour)}#{separator}#{leading_zero_on_single_digits(minute)}">#{leading_zero_on_single_digits(convert_to_pm(hour))}#{separator}#{leading_zero_on_single_digits(minute)} #{period}</option>\n))
            else
              hour_minute_options << (%(<option value="#{leading_zero_on_single_digits(hour)}#{separator}#{leading_zero_on_single_digits(minute)}" selected="selected">#{leading_zero_on_single_digits(convert_to_pm(hour))}#{separator}#{leading_zero_on_single_digits(minute)} #{period}</option>\n))
            end
          end
        end
      end
      select_html(options[:field_name] || 'hour_minute', hour_minute_options, options)
    end
  end
  
  def convert_to_pm(hour)
    return hour > 12 ? hour - 12 : hour
  end
end