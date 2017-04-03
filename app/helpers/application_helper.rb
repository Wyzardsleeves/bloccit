module ApplicationHelper
  #defines a method named form_group_tag which takes two arguments.
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    #calls the content_tag helper method.
    content_tag :div, capture(&block), class: css_class
  end  
end
