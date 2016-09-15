class Answer < ActiveRecord::Base
  belongs_to :question, touch: true
  belongs_to :user
  validates :body, presence: true, uniqueness: {scope: :question_id}
end
