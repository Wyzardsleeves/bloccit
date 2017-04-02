module SponsoredPostHelper
  def number_field(object_name, method, options = {})
    Tags::NumberField.new(object_name, method, self, options).render
  end
end
