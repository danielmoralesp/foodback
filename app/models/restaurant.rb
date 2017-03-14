class Restaurant < ActiveRecord::Base
  has_many :reviews
  belongs_to :category

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [address1, address2, city, state, zipcode].join(', ')
  end
end
