class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  
  def self.top_ten(category)
    top_media = Work.where(category: category).sort_by{|work| -work.votes.count}.first(10)
    return top_media
  end 
  
  def self.spotlight
    return spotlight_work = Work.all.max_by { |work| work.votes.count }
  end
  
end
