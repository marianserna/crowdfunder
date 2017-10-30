class Category < ApplicationRecord
  has_many :projects
  def self.options_for_select
    Category.order(:name).pluck(:name, :id)
    # OR
    # Category.order(:name).map { |category| [ category.name, category.id ] }
  end
end
