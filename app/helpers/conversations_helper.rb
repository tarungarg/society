module ConversationsHelper
  def recipients_options
    s = ''
    if current_tenant
      current_tenant.users.each do |user|
        s << "<option value='#{user.id}' data-img-src='#{gravatar_image_url(user.email, size: 50)}'>#{user.name} < #{user.email} > </option>"
      end
      s.html_safe
    end
  end
end
