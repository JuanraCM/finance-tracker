class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, :through => :user_stocks
  has_many :friendships
  has_many :friends, :through => :friendships

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :matches, lambda { |field_name, token| where("#{field_name} like ?", "%#{token}%") }

  scope :find_by_first_name, lambda { |token| matches('first_name', token) }

  scope :find_by_last_name, lambda { |token| matches('last_name', token) }

  scope :find_by_email, lambda { |token| matches('email', token) }

  def self.search(token)
    token.strip!
    token.downcase!

    results = (
        find_by_first_name(token) +
        find_by_last_name(token)  +
        find_by_email(token)
      ).uniq

    return nil unless results
    results
  end


  def full_name
    return "#{first_name} #{last_name}".strip if first_name || last_name
    "Anonymous"
  end


  def stock_already_added?(ticker)
    stock = Stock.find_by_ticker(ticker)
    return false unless stock
    user_stocks.where(:stock_id => stock.id).exists?
  end


  def under_stock_limit?
    user_stocks.count < 10
  end


  def can_add_stock?(ticker)
    under_stock_limit? && !stock_already_added?(ticker)
  end


  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end


  def not_friend_with?(friend_id)
    friendships.where(:friend_id => friend_id).count == 0
  end
end
