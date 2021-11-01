# == Schema Information
#
# Table name: recommendeds
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_recommendeds_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Recommended < ApplicationRecord
  belongs_to :product
end
