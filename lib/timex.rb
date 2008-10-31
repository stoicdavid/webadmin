  class Timex<Time
    def step(other_time, increment) 
      raise ArgumentError, "step can't be 0" if increment == 0 
      increasing = self < other_time 
      if (increasing && increment < 0) || (!increasing && increment > 0) 
        yield self 
        return
      end 
      d = self 
      begin 
        yield d 
        d += increment 
      end while (increasing ? d <= other_time : d >= other_time) 
    end 
    def upto(other_time) 
      step(other_time, 1) { |x| yield x } 
    end 
  end