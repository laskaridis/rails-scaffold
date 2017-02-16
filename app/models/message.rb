class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :sender, presence: true
  validates :recipient, presence: true
  validates :subject, presence: true
  validates :message, presence: true

  scope :sent_by, ->(user) { where(sender_id: user.id) }
  scope :received_by, ->(user) { where(recipient_id: user.id) }
  scope :unread, -> { where(read: false) }
end
