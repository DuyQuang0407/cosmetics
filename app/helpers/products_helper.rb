module ProductsHelper
  def ribbon(product)
    html = ""
    html << new_product if product.newly?  
    html << promotion(product.promotion.value) if product.discount?
    html.html_safe
  end

  def popular
    ribbon_tag 'popular', :left
  end

  def promotion(value)
    discount_tag("-#{value}%")
  end

  def new_product
    ribbon_tag 'new', :left
  end

  def favourites(user)
    [ 
      {
        icon: 'far fa-heart',
        type: 'like',
        will_show: is_user?(user),
        badge: false
      }, 
      {
        icon: 'fas fa-cart-plus',
        type: 'add2cart',
        will_show: is_user?(user),
        badge: true
      }
    ]
  end

  def description_headers
    [:description, :recommended, :benefit, :ingredient, :how_to_use]
  end

  def tab_attributes(name)
    %Q(
      id=tab-#{name} data-bs-toggle=pill data-bs-target=detail-#{name} type=button role=tab aria-controls=pills-#{name}
    )
  end

  def detail_active(index)
    class_names({'active': index == 0})
  end
  
  private
  def ribbon_tag(name, position=:right)
    cls = 'ribbon-left' if position == :left
    content_tag :div, class: "ribbon text-uppercase #{cls}" do
      content_tag :span, t("ribbon.#{name}")
    end
  end

  def discount_tag(value)
    content_tag :div, class: 'badge-container' do
      content_tag :div, value, class: 'badge sale'
    end
  end
end
