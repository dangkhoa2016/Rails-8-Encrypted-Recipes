class String
  def to_duration
    # Regular expression to match the number and unit
    match = self.match(/(\d+)\s*(seconds?|minutes?|hours?|days?)/i)

    return 0 unless match

    # Extract the number and unit from the match
    value = match[1].to_i
    unit = match[2].downcase

    # Convert to seconds based on the unit
    case unit
    when 'second', 'seconds'
      value
    when 'minute', 'minutes'
      value * 60
    when 'hour', 'hours'
      value * 3600
    when 'day', 'days'
      value * 86400
    else
      0
    end
  end
end

class Integer
  def to_duration
    return 0 if self <= 0

    # Calculate the number of days, hours, minutes, seconds
    days = self / 86400
    hours = (self % 86400) / 3600
    minutes = (self % 3600) / 60
    seconds = self % 60

    # Create an array to store the duration parts
    duration = []
    duration << "#{days} day#{'s' if days != 1}" if days > 0
    duration << "#{hours} hour#{'s' if hours != 1}" if hours > 0
    duration << "#{minutes} minute#{'s' if minutes != 1}" if minutes > 0
    duration << "#{seconds} second#{'s' if seconds != 1}" if seconds > 0

    # Combine the parts together
    duration.join(' ')
  end
end

