module ApplicationHelper
  #defines a method named form_group_tag which takes two arguments.
  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
   end
end

=begin  Old helper contents
module ApplicationHelper
  #defines a method named form_group_tag which takes two arguments.
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    #calls the content_tag helper method.
    content_tag :div, capture(&block), class: css_class
  end
end
=end
