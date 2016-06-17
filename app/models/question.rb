class Question < ActiveRecord::Base
  # has_many helps us set up the association between question model and the answer model.
  # In this case 'has_many' assumes that the answers table containt a field named 'question_id' that is an integer (this is a Rails convention)
  # the dependent option takes values like 'destroy' and 'nullify'
  # 'destroy' will make Rails automatically delete associated answers before deleting the question.
  # 'nullify' will make Rails turn 'question_id' values of asociated records to 'NULL' before deleting the question.
  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user

  validates(:title, {presence: {message: "must be present!"}, uniqueness: true})
  validates :body, presence: true, length: {minimum: 7}
  # by having the option: uniqueness: {scope: :title} it ensures that the body
  # must be unique in combination with the title.
  validates :body, presence: true,
                    length: {minimum: 7},
                    uniqueness: {scope: :title}

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :email, format: VALID_EMAIL_REGEX

  validate :no_monkey
  validate :no_title_in_body

  after_initialize :set_defaults
  before_validation     :cap_title, :squeeze_title_body

  # Scope
  # scope :recent, lambda{|count| where("created_at >?", 3.day.ago).limit(count)}
  #OR
  def self.recent(count)
    where("created_at > ?", 3.day.ago).limit(count)
  end

  # scope :search, lambda {|word| where("title ILIKE ? OR body ILIKE ?", "%#{word}%", "%#{word}%")}

  def self.search(word)
    where("title ILIKE ? OR body ILIKE ?", "%#{word}%", "%#{word}%" )
    # where("title ILIKE :word OR body ILIKE :word", {word: "%#{word}%"})
  end

  def new_first_answers
     answers.order(created_at: :desc)
  end
  #Product.where("price BETWEEN 100 AND 300").order(name: :desc).limit(10)

  # User.where("first_name != 'john' OR last_name != 'john'")



  # def self.updated_after(date)
  #   where("updated_at > ?", date)
  # end
  # scope :updated_after, lambda{|date| where("updated_at > ?", date)}

  # Product.where("sale_price < price").order(updated_at:, sale_price:).limit(3)

  # validates :name, presence: true
  # validates :price, numericality: {greater_than: 0, less_than: 1000}

  # before_destroy :notify_admin # to private method section

  # Destroy runs any callbacks on the model while delete doesn't

  private

  #customer constraint functions
  def no_monkey
    if title && title.downcase.include?("monkey")
      errors.add(:title, "No monkey please!")
    end
  end

  def no_title_in_body
    if body.include?(title)
      errors.add(:body, "No title in the body please!")
    end
  end

  def set_defaults
    self.view_count ||= 0
  end

  def cap_title
    self.title = title.capitalize
  end

  def squeeze_title_body
    self.title = title.squeeze(" ")
    # self.title.squeeze!(" ")
    self.body = body.squeeze(" ")
    # self.body.squeeze!(" ")
  end

  # def notify_admin
  #   puts "Product is about to be deleted"
  #   Rails.logger.debug("Product is about to be deleted")
  # end

  # def unique_name
  #   if name.include?("apple", "microsoft", "sony").reverse
  #     errors.add(:name, "Cannot use that as the name")
  # end

end
