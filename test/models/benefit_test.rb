# == Schema Information
#
# Table name: benefits
#
#  id         :bigint           not null, primary key
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_benefits_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
require "test_helper"

class BenefitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
