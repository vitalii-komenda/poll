class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  belongs_to :user

  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  validates :content, :length => {:minimum => 5}
  validate :answers_length_enough


  def answers_length_enough
    if self.answers.length < 2
      errors.add :answers, 'should be more than or equal 2'
    end
    if self.answers.select { |q| q._destroy == false }.length < 2
      errors.add :answers, 'cannot be less then 2'
    end
  end
end