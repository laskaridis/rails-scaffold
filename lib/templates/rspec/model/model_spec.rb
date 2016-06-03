require 'rails_helper'

<% module_namespacing do -%>
describe <%= class_name %>, <%= type_metatag(:model) %> do
<% attributes.each do |attribute| -%>
<% if attribute.required? -%>
  it { should validate_presence_of :<%= attribute.name %> }
<% end -%>
<% if attribute.attr_options[:limit] -%>
  it { should validate_length_of(:<%= attribute.name %>).is_at_most(<%= attribute.attr_options[:limit] %>) }
<% end -%>
<% if attribute.has_index? && !attribute.has_uniq_index? -%>
  it { should have_db_index :<%= attribute.name %> }
<% end -%>
<% if attribute.has_uniq_index? -%>
  it { should have_db_index(:<%= attribute.name %>).unique(:true) }
<% end -%>
<% end -%>
end
<% end -%>
