class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :schedules
  has_many :importants,  dependent: :destroy
  has_many :important_schedules, through: :importants, source: :schedule

  def important(schedule)
    self.importants.find_or_create_by(schedule_id: schedule.id)
  end
  
  def unimportant(schedule)
    important = self.importants.find_by(schedule_id: schedule.id)
    important.destroy if important
  end
  
  def important?(schedule)
    self.important_schedules.include?(schedule)
  end
end
