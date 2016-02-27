module ApplicationHelper
  
  def display_changes(old, new)
    return new if old.blank? || old == new
    "#{old} &rarr; #{new}".html_safe
  end
  
end
