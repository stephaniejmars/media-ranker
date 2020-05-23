class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  #add relationships 
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true

  # validates :creator, presence: true, length: {minimum: 10}
  
end
