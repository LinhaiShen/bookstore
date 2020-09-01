Trestle.resource(:system_locs) do
  menu do
    item :system_locs, icon: "fa fa-star"
  end
  
  table do
    column :type
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
      row do
        col(sm: 2) { text_field :code }
        col(sm: 1) { text_field :ops, :value => "sysloc", :readonly => true }
        col(sm: 1) { select :loctype,Location::LOCTYPES }
        col(sm: 1) { text_field :container }
      end
      divider
      row do
        col(sm: 1) { select :building, Location::BUILDINGS }
        col(sm: 1) { select :room, Location::ROOMS }
        col(sm: 1) { select :aisle, Location::AISLES }
        col(sm: 1) { select :face, Location::FACES }
        col(sm: 1) { text_field :column, :value => 1 }
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
  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |system_loc|
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
  #   params.require(:system_loc).permit(:name, ...)
  # end
end
