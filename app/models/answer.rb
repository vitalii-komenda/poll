class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :votes

  validates_presence_of :content
  validates :content, :length => {:minimum => 2}
end