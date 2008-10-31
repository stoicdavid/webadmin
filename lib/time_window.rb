class TimeWindow

  attr_accessor :window, :ranges, :rules

  Days = {
    "Mon" => 1,
    "Tue" => 2,
    "Wed" => 3,
    "Thu" => 4,
    "Fri" => 5,
    "Sat" => 6 }
  
  Dias = {
    1 => "Lunes",
    2 => "Martes",
    3 => "Miércoles",
    4 => "Jueves",
    5 => "Viernes",
    6 => "Sábado"}

  def initialize (window)
    @window = window
    @ranges = []
    @rules = []
    parse_window
  end

  def include? (time)
    req = time.strftime("%w%H%M").to_i
    result = false
    @ranges.each{ |range|
      if range[0] <= req && req < range[1]
        result = true
      end
    }
    result
  end

  private


  REGEXDAYS = %r{Mon|Tue|Wed|Thu|Fri|Sat}

  #Parse the input
  def parse_window
    @window.split(";").each { |window|
      next if window.strip == ""
      rule = Hash.new
      window.strip!  
      rule[:rule] = window
      days = parse_days window
      hours = parse_time window   
      rule[:days] = stringify_days days
      rule[:hours] = stringify_hours hours
      days.each {|day|
        hours.each {|hour|
          @ranges << [day[0]*10000+hour[0], day[1]*10000+hour[1]]
        }
      }
      @rules << rule
    }
  end

  def parse_days (days)
    result = []
    days.scan(/(?:(#{REGEXDAYS})-(#{REGEXDAYS})|(#{REGEXDAYS}))/) do     
      if $3                # it's just one day
        result << [Days[$3],Days[$3]]
      else                # it's a range
        result << [Days[$1],Days[$2]]
      end
    end
    if result.empty?
      result = [[1,5]]
    end
    result
  end

  def parse_time (time)
    result = []
    time.scan(/([012]\d[0-6]\d)-([012]\d[0-6]\d)/) do
      result << [$1.to_i, $2.to_i]
    end
    if result.empty?
      result = [[0,2400]]
    end
    
    result
  end
  
  def stringify_days days
    result = ""
    days.each do |day|
      if day[0] == day[1]
        result += "#{Dias[day[0]]} "
      else
        "#{Dias[day[0]]} - #{Dias[day[1]]} "
      end
    end
    result
  end
  
  def stringify_hours hours
    result = ""
    hours.each do |hour|
      first = hour[0].to_s.insert(-3, ":")
      last = hour[1].to_s.insert(-3, ":")
      result += "#{first}-#{last} "
    end
    result  
  end
end