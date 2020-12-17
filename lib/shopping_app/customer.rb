require_relative "user"
require_relative "cart"

class Customer < User
  attr_reader :cart

  def initialize(name)
    super(name) # TODO: 継承関係のテキストのリンクを添える
    @cart = Cart.new(self) # Customerインスタンスは生成されると、自身をオーナーとするカートを持ちます。
  end

end
