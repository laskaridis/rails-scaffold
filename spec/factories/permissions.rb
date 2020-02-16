FactoryBot.define do
  factory :permission do
    name     { 'Permission' }
    action   { 'dosomething' }
    resource { 'somewhere' }
  end
end
