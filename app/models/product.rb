class Product < ActiveRecord::Base
  validates :price, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1000}
  validates :name, presence: true, uniqueness: true
  validate :reserved_word

  before_destroy :notify_admin

  #Product.where("price BETWEEN 100 AND 300").order(name: :desc).limit(10)
  #Product.where("price != sale_price").order("sale_price, updated_at").limit(10)
  def notify_admin
    puts "Product is about to be deleted"
    # Rails.logger.debug("Product is about to be deleted")
  end

  def self.created_at(date1, date2)
    where("created_at BETWEEN ? AND ?", date1, date2)
  end


  private

  def reserved_word
   if name && name.downcase.include?("Apple")
     errors.add(:title, "Invalid name")
   end
  end
end
