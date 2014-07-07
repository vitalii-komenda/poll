class Question < ActiveRecord::Base
  has_many :answers, :dependent => :destroy
  belongs_to :user

  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true


  # validates_length_of :answers, :minimum => 2, :message => "Votes should be more then or equal 2"
  validate :answers_length_enough


  def answers_length_enough
    if self.answers.length < 2
      errors.add :answers, 'should be more than or equal 2'
    end
    if self.answers.length == 2 and
        self.answers.any? { |q| q._destroy == true }
      errors.add :answers, 'cannot be less then 2'
    end
  end
end