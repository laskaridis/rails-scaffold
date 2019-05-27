class Notification < ApplicationRecord
  validates :subject, presence: true, length: { maximum: 100 }
  validates :type,    presence: true, length: { maximum: 50 }
  validates :body,    presence: true

  belongs_to :user
  
  scope :unread, -> { where(read: false) }

  def unread?
    !read?
  end

  # use `type` column name for notification type instead of STI
  def self.inheritance_column
    nil
  end
end
