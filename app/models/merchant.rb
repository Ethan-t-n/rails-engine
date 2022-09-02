class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  # def self.find_one_by_name(name)
  #   where(“name ILIKE ?“, “%#{name}%“).order(:name).first
  # end

    #temporary experiment with method chaining 
   scope :search_merchant,  -> (name) {where('name ILIKE ?', "%#{name}%")}

end 