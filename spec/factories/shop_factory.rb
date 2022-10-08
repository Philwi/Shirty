class ShopFactory
  def initialize(name: 'I Hate Everything')
    @name = name
  end

  def create
    ::Shirty::Repositories::Shops.new.create_shop_by_name(name)
  end

  private

  attr_reader :name
end
