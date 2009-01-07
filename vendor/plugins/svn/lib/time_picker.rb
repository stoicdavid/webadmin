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
              hour_minute_options << (%(<option value="#{(hour)}#{separator}#{(minute)}">#{(hour)}#{separator}#{(minute)}</option>\n))
            else
              hour_minute_options << (%(<option value="#{(hour)}#{separator}#{(minute)}" selected="selected">#{(hour)}#{separator}#{(minute)}</option>\n))
            end
          end
        end
      else
        0.upto(23) do |hour|
          period = 'AM'
          period = 'PM' if hour >= 12
          0.step(59, options[:minute_step] || 1) do |minute|
            unless (val_hour == hour) && (val_minute == minute)
              hour_minute_options << (%(<option value="#{(hour)}#{separator}#{(minute)}">#{(convert_to_pm(hour))}#{separator}#{(minute)} #{period}</option>\n))
            else
              hour_minute_options << (%(<option value="#{(hour)}#{separator}#{(minute)}" selected="selected">#{(convert_to_pm(hour))}#{separator}#{(minute)} #{period}</option>\n))
            end
          end
        end
      end
      select_html (options[:field_name] || 'hour_minute', hour_minute_options, options)
    end
  end
  
  def convert_to_pm(hour)
    return hour > 12 ? hour - 12 : hour
  end
  
  def select_html(type, html_options, options, select_tag_options = {})
            name_and_id_from_options(options, type)
            select_options = {:id => options[:id], :name => options[:name]}
            select_options.merge!(:disabled => 'disabled') if options[:disabled]
            select_options.merge!(select_tag_options) unless select_tag_options.empty?
            select_html = "\n"
            select_html << content_tag(:option, '', :value => '') + "\n" if options[:include_blank]
            select_html << html_options.to_s
            content_tag(:select, select_html, select_options) + "\n"
  end
   def name_and_id_from_options(options, type)
            options[:name] = (options[:prefix] || DEFAULT_PREFIX) + (options[:discard_type] ? '' : "[#{type}]")
            options[:id] = options[:name].gsub(/([\[\(])|(\]\[)/, '_').gsub(/[\]\)]/, '')
  end
end