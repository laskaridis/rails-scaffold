class Language < ApplicationRecord
  validates :code, presence: true, uniqueness: { case_sensitive: false }

  def self.default
    find_by!(code: I18n.default_locale)
  end

  def name
    I18n.t("languages.#{code.downcase}")
  end
end
