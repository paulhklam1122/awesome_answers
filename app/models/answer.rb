class Answer < ActiveRecord::Base
  belongs_to :question, dependent: :destroy
  validates :body, presence: true, uniqueness: {scope: :question_id}
end
