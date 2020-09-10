class TaxReference < ApplicationRecord
  validates :year, uniqueness: true
  MAX_MONTHLY_HOURS = 172

  def worker_contribution(number_of_hours)
    return self.hourly_wage * number_of_hours * self.worker_percentage / 100
  end

  def employer_contribution(number_of_hours)
    return self.hourly_wage * number_of_hours * self.employer_percentage / 100
  end

  def total_contribution(number_of_hours)
    return self.employer_contribution(number_of_hours) +
        self.worker_contribution(number_of_hours)
  end
end
