class Role < ApplicationRecord
    scope :alphabetical, -> { order(name: :asc) }
end
