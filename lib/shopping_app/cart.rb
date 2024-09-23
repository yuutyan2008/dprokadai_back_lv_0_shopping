require_relative "item_manager"
require_relative "./ownable" #現在のディレクトリからのパス
require_relative "./wallet" #現在のディレクトリからのパス

class Cart < Wallet #Walletクラスを継承
  include ItemManager
  include  Ownable #

  def initialize(owner)
    self.owner = owner#cartのownerを引数で受取り、@ownerインスタンス変数にownerの値が設定される
    @items = []#カートのアイテムを格納するため、@itemsインスタンス変数を作成して初期化。
    # binding.irb
  end

  def items
    # Cartにとってのitemsは自身の@itemsとしたいため、ItemManagerのitemsメソッドをオーバーライドします。
    # CartインスタンスがItemインスタンスを持つときは、オーナー権限の移譲をさせることなく、自身の@itemsに格納(Cart#add)するだけだからです。
    @items
  end

  def add(item)
    @items << item
  end

  #カート内の全てのアイテムの合計金額を計算
  def total_amount
    @items.sum(&:price)
  end


  #カートのチェックアウト処理
  def check_out
    # binding.irb 
    return if owner.wallet.balance < total_amount
  # ## 要件
  #   - カートの中身（Cart#items）のすべてのアイテムの購入金額が、カートのオーナーのウォレットからアイテムのオーナーのウォレットに移されること。
    # item.owner.wallet += self.owner.wallet
  #   - カートの中身（Cart#items）のすべてのアイテムのオーナー権限が、カートのオーナーに移されること。
  

  #   - カートの中身（Cart#items）が空になること。
  #   
  #
    items.each do |item|#itemsメソッドを呼び出して@items配列を取得し、その配列に対してeachメソッドを適用
      
      #ownerオブジェクトのwalletインスタンスのwithdrawメソッドを呼ぶ
      #
      owner.wallet.withdraw(item.price) #オーナー(customer)の財布から購入商品の値段を引く
      #オーナー(customer)の財布からsellerの財布に購入商品の値段を増やす
      item.owner.wallet.deposit(item.price)#残高を追加する

      #所有者をsellerからオーナー(customer)にする
      # binding.irb 
      item.owner= owner
      
    end
  
    # binding.irb
      @items = []
  # ## ヒント
  #   - カートのオーナーのウォレット ==> self.owner.wallet
  #   - アイテムのオーナーのウォレット ==> item.owner.wallet
  #   - お金が移されるということ ==> (？)のウォレットからその分を引き出して、(？)のウォレットにその分を入金するということ
  #   - アイテムのオーナー権限がカートのオーナーに移されること ==> オーナーの書き換え(item.owner = ?)
  end

end
