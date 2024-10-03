class Car < ApplicationRecord
  belongs_to :owner
  has_many :reviews
  has_many :favourites
end
