class Language < ApplicationRecord
  validates :code, presence: true, uniqueness: { case_sensitive: false }

  def name
    I18n.t("languages.#{code.downcase}")
  end
end
