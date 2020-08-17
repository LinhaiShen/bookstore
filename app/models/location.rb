class Location < ApplicationRecord
    #self.primary_key = :code
    scope :physical, -> {where(:type => nil)}
    enum ops: {storage:0, receiving:1, shipping:2, vas:3, suspend:9}
    enum loctype: {rack:0, ground:1}
    LOCTYPES = ["rack","ground"]
    BUILDINGS = ["1","2","3","4","5","6","7","8","9","0"]
    ROOMS = ["1","2","3","4","5","6","7","8","9","0"]
    FACES = ["R","L"]
    AISLES = ["A","B","C","D","E","F","G","H","I"]
    LAYERS = [1,2,3,4,5,6,7,8,9,10]

    before_save :default_values
    def default_values
        #location_code = self.aisle+self.face+("%03d" % self.column)+self.layer.to_s+'R'+self.room+'B'+self.building
        location_code = self.aisle+("%03d" % self.column)+self.layer.to_s+'R'+self.room+'B'+self.building
        #self.code = location_code
        if self.code.blank?
        #    if !Location.exists?(code: location_code)
                self.code = location_code
        #    end
        end
    end

    def self.to_csv
        CSV.generate do |csv|
          csv << column_names
          all.each do |result|
            csv << result.attributes.values_at(*column_names)
          end
        end
    end
end
