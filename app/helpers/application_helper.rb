module ApplicationHelper
  def background_image_url
    Tenant.current.image_url
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
               concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
               concat message
             end)
    end
    nil
  end

  def truncate_text(text, length = 40)
    truncate(text, length: length)
  end

  def convert_to_timezone(time)
    Time.utc_to_local(time)
  end

  def convert_time_to_basic(time)
    time.strftime('%b %d, %Y at %I:%M%p')
  end

  def basic_date_only(time)
    time.strftime('%b %d, %Y')
  end

  def basic_time_only(time)
    time.strftime('%I:%M %p')
  end

  def member_occupation
    ' - ' + current_user.occupation if current_user.occupation.present?
  end

  def member_name
    current_user.name
  end

  def member_name_and_occupation
    member_name.to_s
  end

  def joining_date
    current_user.created_at.strftime('%b. %Y')
  end

  def active_page(active_page)
    @active == active_page ? 'active' : ''
  end

  def relative_time(created_at)
    time_ago_in_words(created_at)
  end

  def formatted_time(time)
    time.to_formatted_s(:short)
  end

  def randomized_bg_class
    classes = ['label-danger', 'label-info', 'label-success']
    classes[rand(classes.size)]
  end
end
