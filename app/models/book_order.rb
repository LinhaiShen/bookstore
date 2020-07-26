class BookOrder < ApplicationRecord
    has_many :bookorderlines
    enum status: {created:0, confirmed:1, fulfilled:5, cancelled:9}
    scope :today, -> {where(created_at: Time.current.beginning_of_day..Time.current.end_of_day)}
    scope :open, -> {where(:status => ["created","confirmed"])}
    before_save :default_values
    def default_values
        if self.id.blank?
            if BookOrder.today.empty?
                self.id = Time.current.strftime("%Y%m%d")+"001"
            else
                self.id = BookOrder.today.last.id + 1
            end
        end
    end
end
