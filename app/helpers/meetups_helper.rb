module MeetupsHelper
  def registration_status(meetup)
    if is_meetup_available?(meetup)
      meetup.attendees.count.to_s + '  (上限：' + meetup.attendee_limit.to_s + ')'
    else
      '己額滿'
    end
  end

  def is_meetup_available?(meetup)
    meetup.attendee_limit > meetup.attendees.count  
  end

  def next_meetup_date(meetup)
    day_offset = meetup.day.to_i
    calculate_date(day_offset) + next_meetup_time(meetup)
  end

  def calculate_date(day_offset)
    meetup_day = day_offset
    current_day = Time.now.wday   
    next_date = DateTime.now + (meetup_day - current_day).days      
    
    if meetup_day < current_day 
      next_date += 7.days  # Next week
    end
    next_date.strftime('%Y/%m/%d') + ' (' + I18n.t(:"date.day_names")[day_offset] + ') '
  end

  def next_meetup_time(meetup)
    meetup.start_time + ":00" + " ~" + meetup.end_time + ":00"
  end
end
