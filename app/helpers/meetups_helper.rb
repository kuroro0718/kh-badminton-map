module MeetupsHelper
  def calculate_date(day_offset)
    meetup_day = day_offset
    current_day = Time.now.wday   
    next_date = DateTime.now + (meetup_day - current_day).days      
    
    if meetup_day < current_day 
      next_date += 7.days  # Next week
    end
    next_date.strftime('%Y/%m/%d')
  end

  def next_meetup_date(day_offset)
    calculate_date(day_offset) + ' (' + I18n.t(:"date.day_names")[day_offset] + ')'
  end
end
