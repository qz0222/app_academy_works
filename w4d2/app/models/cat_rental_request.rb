# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  validates :status, presence: true, inclusion: {in: ["PENDING", "APPROVED", "DENIED"]}
  validate :overlapping_approved_requests

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "Cat"

  def overlapping_requests
    CatRentalRequest.find_by_sql(<<-SQL)
      SELECT
        *
      FROM
        cat_rental_requests
      WHERE
        cat_rental_requests.cat_id = #{self.cat_id} AND
        ('#{self.start_date}' < cat_rental_requests.end_date OR
        cat_rental_requests.start_date < '#{self.end_date}')
    SQL
  end

  def overlapping_approved_requests
    if self.overlapping_requests.select { |request| request.status == "APPROVED" }.length > 0
      self.errors.add(:start_date, "Schedule conflict!")
    end
  end

end
