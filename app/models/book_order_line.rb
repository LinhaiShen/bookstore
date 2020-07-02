class BookOrderLine < ApplicationRecord
  belongs_to :book
  belongs_to :bookorder
  enum status: {created:0, fulfilled:5, cancelled:9}
end
