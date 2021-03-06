# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  price       :decimal(8, 2)
#  quantity    :integer          default(0)
#  slug        :string
#  status      :integer          default("newly")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_slug         (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many_attached :images
  belongs_to :category
  has_many :benefits, dependent: :destroy
  has_many :user_likes, foreign_key: 'product_id', class_name: 'Favourite', dependent: :delete_all
  has_many :product_ingredients, dependent: :destroy
  has_many :ingredients, through: :product_ingredients
  has_one :recommended, dependent: :destroy
  has_one  :promotion, dependent: :destroy

  enum status: [     
    :newly, :normally, :close_date, 
    :out_of_stocks, :stop_producing, :waiting_price 
  ] 

  scope :by_limit, -> (size=50) { includes(:category).limit(size)}

  scope :by_product, -> (id) { 
    includes(:promotion, :recommended)
    .left_joins(:promotion, :recommended)
    .where(id: id).or(Product.where(slug: id)).first 
  }
  
  after_create_commit { broadcast_prepend_to "products" }
  after_destroy_commit { broadcast_remove_to "products" }
  after_update_commit { 
    broadcast_replace_to :show, partial: 'products/item', locals: {item: self}, target: "show-product-#{id}" 
    broadcast_replace_to :products, partial: 'products/product', locals: {product: self}, target: "product_#{id}" 
  }

  def attach_url(index = 0)
    return nil unless self.images.attached?
    len = self.images.length - 1
    image = self.images[index > len ? len :  index]
    return nil unless image.present?
    is_storage_from_disk? ? storage_local_path(image.key) : storage_public_path(image.key)
  end

  def thumbnail
    return nil unless self.images.attached?
    image = self.images.first
    image.variable? ? image.variant(resize: '200x200') : image
  end

  def category_name
    self.category.name.gsub(/\-/, ' ')
  end

  def discount?
    self.promotion && self.promotion.discount? && self.promotion.started? || false
  end

  def discount
    return self.price unless self.discount?
    self.price - (self.price*self.promotion.value)/100.0
  end

  private
  def new_product?
    self.created_at + 7.days <= Time.zone.now
  end
end
