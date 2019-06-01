class Schedule < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 255 }
  
  validates_datetime :end, after: :start
  
  validates_datetime :start, after: lambda { DateTime.now },
                               after_message: "must be be more future than now"
                               
  validates_datetime :end, after: lambda { DateTime.now },
                               after_message: "must be be more future than now"
end
