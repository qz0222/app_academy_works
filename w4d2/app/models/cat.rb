# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  validates :sex, presence: true, inclusion: {in: %w(M F)}
  validates :name, presence: true
  validates :birth_date, presence: true

  has_many :cat_rental_requests,
    dependent: :destroy, 
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "CatRentalRequest"

  def age
    Time.now.year - self.birth_date.year
  end

end
