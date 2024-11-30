class Address < ApplicationRecord

  def complete?
    country.present? && state.present? && city.present?
  end
end
