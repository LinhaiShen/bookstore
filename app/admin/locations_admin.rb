Trestle.resource(:locations) do
  menu do
    group :Facility do
    item :locations, icon: "fa fa-warehouse"
    end
  end

  table do
    column :code
    column :building
    column :room
    column :aisle
    column :face
    column :column
    column :layer
    actions
  end

  form do |location|
    tab :Location do
      static_field :code
      divider
      row do
        col(sm: 1) { select :building, Location::BUILDINGS }
        col(sm: 1) { select :room, Location::ROOMS }
        col(sm: 1) { select :aisle, Location::AISLES }
        col(sm: 1) { select :face, Location::FACES }
        col(sm: 1) { text_field :column, required: true }
        col(sm: 1) { select :layer, Location::LAYERS }
      end
      #text_field :building
      #text_field :room
      #text_field :aisle
      #text_field :face
      #text_field :column
      #text_field :layer
      divider

      row do
        col(sm: 2) { text_field :containercapa, append: "unit" }
        col(sm: 2) { text_field :weightcapa, append: "KG" }
        col(sm: 2) { text_field :heightcapa, append: "mm" }
        col(sm: 2) { text_field :volumecapa, append: "L" }
      end
    end
  end

  controller do
    def show
      respond_to do |format|
        format.html { render :show }
        format.pdf do
          pdf = Prawn::Document.new
          pdf.table([ [pcode = instance.code], [pbuilding = instance.building] ])
          send_data pdf.render,
            filename: "export.pdf",
            type: 'application/pdf',
            disposition: 'inline'
        end
      end
    end

    def create
      location_code = instance.aisle+("%03d" % instance.column)+instance.layer.to_s+'R'+instance.room+'B'+instance.building
      #flash[:message] = location_code
      #redirect_to LocationsAdmin.path
      if Location.exists?(code: location_code)
        flash.now[:error] = flash_message("location exists", title: "Warning!", message: location_code + I18n.t(:error_record_exists) )
        render "new" , status: :unprocessable_entity
      else
        if save_instance
          respond_to do |format|
            format.html do
              flash[:message] = flash_message("create.success", title: "Success!", message: "The %{lowercase_model_name} was successfully created.")
              redirect_to_return_location(:create, instance, default: admin.instance_path(instance))
            end
            format.json { render json: instance, status: :created, location: admin.instance_path(instance) }

            yield format if block_given?
          end
        end

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
