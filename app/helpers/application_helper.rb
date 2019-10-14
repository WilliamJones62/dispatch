module ApplicationHelper
  def display_date(date)
    if date
      formatted = date.strftime("%-I:%M%p on %-d %b %Y")
    else
      formatted = ' '
    end
  end
end
