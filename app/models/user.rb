class User < ActiveRecord::Base
  # scope :created_after, ->(date) {where("created_at > ?", date)}
  def self.search_term(search_term)
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "#{search_term}", "#{search_term}", "#{search_term}")
    # where("first_name ILIKE :search_term OR last_name ILIKE :search_term, email ILIKE :search_term", {search_term: "#{search_term}"})
  end

  def self.search_term1(search_term)
    where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
    # where("first_name ILIKE :search_term OR last_name ILIKE :search_term, email ILIKE :search_term", {search_term: "%#{search_term}%"})
  end

  def self.created_after(date)
    where("created_at > ?", date)
  end
  # scope :created_after, lambda{|date| where("created_at >?", date)}

  def self.created_at(date1, date2)
    where("created_at between ? AND ?", date1, date2)
  end
end
