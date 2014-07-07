class Vote < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user

  validates_presence_of :answer, :answer_id
  validates_presence_of :user, :user_id

  validates_uniqueness_of :user_id, :scope => [:user_id, :answer_id]
end
