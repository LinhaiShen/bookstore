class BookOrder < ApplicationRecord
    has_many :bookorderlines
    enum status: {created:0, confirmed:1, fulfilled:5, cancelled:9}
end
