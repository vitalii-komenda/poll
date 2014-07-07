class PollsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
    3.times do
      @question.answers.build
    end
  end

  def create
    @question = Question.new(poll_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:notice] = "Successfully created"
      redirect_to polls_path
    else
      render :action => 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(poll_params)
      flash[:notice] = "Successfully updated"
      redirect_to polls_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "Successfully destroyed"
    redirect_to polls_url
  end

  def vote
    vote = Vote.new ({
        :answer_id => params[:id],
        :user_id => current_user.id
    })
    vote.save


    flash[:notice] = "Thank you"
    redirect_to polls_url
  end

  private

  def poll_params
    params.require(:question).permit(:content, :answers_attributes => [:content, :_destroy, :id])
  end
end
