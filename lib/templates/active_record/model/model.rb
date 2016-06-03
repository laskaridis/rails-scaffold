<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
<% end -%>
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<% end -%>
<% attributes.each do |attribute| -%>
<% if attribute.required? %>
  validates :<%= attribute.name %>, presence: true
<% end -%>
<% if attribute.attr_options[:limit] -%>
  validates :<%= attribute.name %>, length: { maximum: <%= attribute.attr_options[:limit] %> }
<% end -%>
<% end -%>
end
<% end -%>
