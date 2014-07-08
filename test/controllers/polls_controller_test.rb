require 'test_helper'

class PollsControllerTest < ActionController::TestCase

  def setup
    @user = User.new uid: 111111111111111111111111111, ip: '127.0.0.1'
    @user.save

    @question = Question.new ({
        content: "What is love",
        user_id: @user.id,
        answers_attributes: [
            {content: "pain", _destroy: 0, id: nil},
            {content: "not pain", _destroy: 0, id: nil}
        ]
    })
    @question.save

    @controller.class.superclass.class_eval do
      @@current_user = nil
      def self.current_user= user
        @@current_user = user
      end

      def current_user
        @@current_user
      end
    end
    @controller.class.superclass.current_user = @user

  end

  def teardown
    @user = nil
  end


  test "the truth" do
    assert true
  end

  test "should create question successfully" do
    post(:create, question: {
        content: "How are you doing",
        answers_attributes: [
            {content: "first a", _destroy: 0, id: nil},
            {content: "second a", _destroy: 0, id: nil}
        ]
    })
    assert_not_nil Question.find_by(content: "How are you doing")
  end

  test "should not create question with less than 2 answers" do
    post(:create, question: {
        content: "How are you doing",
        answers_attributes: [
            {content: "first a", _destroy: 0, id: nil}
        ]
    })
    assert_nil Question.find_by(content: "How are you doing")
  end

  test "should allow to update answers" do

    put(:update, id: @question.id, question: {
        id: @question.id,
        content: "Good!!",
        answers_attributes: [
            {content: "Updated a", _destroy: 0, id: @question.answers[0].id},
            {content: "second a", _destroy: 0, id: @question.answers[1].id}
        ]
    })

    question = Question.find_by(id: @question.id)
    assert_equal "Good!!", question.content
    assert_equal "Updated a", question.answers[0].content
  end

  test "should not allow to delete answer" do
    put(:update, id: @question.id, question: {
        id: @question.id,
        content: "Good!!",
        answers_attributes: [
            {content: "Updated a", _destroy: 0, id: @question.answers[0].id},
            {content: "second a", _destroy: 1, id: @question.answers[1].id}
        ]
    })

    question = Question.find_by(id: @question.id)
    assert_not_nil "Updated a", question.answers[1]
  end
end
