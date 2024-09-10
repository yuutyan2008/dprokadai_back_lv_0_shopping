require_relative "./ownable" #現在のディレクトリからのパス

class Wallet #財布
  include Ownable  #moduleの読み込み
  attr_reader :balance #balance(残高)というゲッターを自動定義し、クラス外からインスタンス変数@balanceの値を取得可能にする
  

  def initialize(owner)
    self.owner = owner
    @balance = 0
  end

  def deposit(amount) #預金
    @balance += amount.to_i#残高に追加する
  end

  def withdraw(amount) #引き出し
    return unless @balance >= amount #「残高が購入金額より多い」がFalseの時、以降の処理が実行されずreturnする
    @balance -= amount.to_i#trueの時、returnを飛ばして以降の処理が実行される
    amount
  end

end