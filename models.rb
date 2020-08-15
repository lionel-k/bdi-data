class ExchangeRate < ActiveRecord::Base
  has_many :currencies

  validates :date, presence: true
  validates :date, uniqueness: true
end

class Currency < ActiveRecord::Base
  belongs_to :exchange_rate

  validates :name, :rate, presence: true
  validates :name, uniqueness: { scope: :exchange_rate }
end
