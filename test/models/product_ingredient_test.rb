# == Schema Information
#
# Table name: product_ingredients
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ingredient_id :bigint           not null
#  product_id    :bigint           not null
#
# Indexes
#
#  index_product_ingredients_on_ingredient_id  (ingredient_id)
#  index_product_ingredients_on_product_id     (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (ingredient_id => ingredients.id)
#  fk_rails_...  (product_id => products.id)
#
require "test_helper"

class ProductIngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
