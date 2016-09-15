class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_owner, only: [:edit, :destroy, :update]

  def new
    @question = Question.new
  end

  def create
    # {
    #   "question": {
    #     "title": "hello",
    #     "body": "dfaskfjdsakl;gjjdfanbfansasdfj"
    #   },
    #   "commit": "Create Question",
    # }

    service = Questions::Create.new params: question_params, user: current_user

    # question = Question.new title: params[:question][:title]
    #                             body: params[:question][:body]
    if service.call
      redirect_to question_path(service.question), notice:  "Question created!"
      # The above one line method only works for redirect but not render
      # render json: params
    else
      @question = service.question
      flash[:alert] = "Question not created!"
      render :new
    end
  end

  def show
    @question.increment!(:view_count)
    # @quesiton.view_count += 1
    # @question.save
    @answer = Answer.new
    respond_to do |format|
      format.html
      format.json {render json: {question: @question, answers: @question.answers}}
    end
  end

  def index
    @questions = Question.eager_load(:answers).order(created_at: :desc).page(params[:page]).per(7)
    respond_to do |format|
      format.html
      format.json {render json: @questions}
    end
  end

  def edit
  end

  def update
    @question.slug = nil
    if @question.update question_params
      redirect_to question_path(@question), notice: "Question updated!"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question deleted!"
  end

  private
  def question_params
    # In the line below we're using the 'strong parameters' feature of Rails
    # In the line we're 'requiring' that the 'params' hash has a key called
    #question and we're only allowing the 'title' and 'body' be fetched
    params.require(:question).permit(:title, :body, :category_id, :image, :tweet_it, {tag_ids: []})
  end

  def authorize_owner
    # unless can? :manage, @question
    #   redirect_to root_path, alert: "Access Denied"
    # end
    redirect_to root_path, alert: "Access Denied" unless can? :manage, @question
  end

  def find_question
    @question = Question.find(params[:id]).decorate
  end

  def current_user_vote
    @question.vote_for(current_user)
  end
  helper_method :current_user_vote
end
