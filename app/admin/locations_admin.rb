Trestle.resource(:locations) do
  menu do
    group :Facility do
    item :locations, icon: "fa fa-warehouse"
    end
  end

  controller do
    def create
      location_code = instance.aisle+("%03d" % instance.column)+instance.layer.to_s+'R'+instance.room+'B'+instance.building
      #flash[:message] = location_code
      #redirect_to LocationsAdmin.path
      if Location.exists?(code: location_code)
        flash[:message] = "Location " + location_code + " already exists!"
        redirect_to LocationsAdmin.path
      else
        @location = Location.new(params[:location])
        @location.save
        flash[:message] = "Location " + location_code + " created!"
        redirect_to LocationsAdmin.path
      end
    end
  end
  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |location|
  #   text_field :name
  #
  #   row do
  #     col { datetime_field :updated_at }
  #     col { datetime_field :created_at }
  #   end
  # end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:location).permit(:name, ...)
  # end
end
