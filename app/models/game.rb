class Game < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many :questions
  has_many :answers, through: :questions
end
