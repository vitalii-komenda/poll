class Message < ActiveRecord::Base
  has_many :answer, class_name: "Message",
           foreign_key: "question_id",
           dependent: :destroy
  belongs_to :question, class_name: "Message"

  accepts_nested_attributes_for :question

end
