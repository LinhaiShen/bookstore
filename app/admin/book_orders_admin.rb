Trestle.resource(:book_orders) do
  menu do
    item :book_orders, icon: "fa fa-star"
  end
  form do
    tab :book_order do
      text_field :id
      text_field :refnumber
      text_field :status
      text_field :deliveryaddress
    end
    tab :notes do
      text_field :notes
    end
    tab :lines, badge: BookOrderLine.where(book_order: instance.id).size do
      table BookOrderLine.where(book_order: instance.id) do
        column :linenumber
        column :book
        column :qty
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
  # form do |book_order|
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
  #   params.require(:book_order).permit(:name, ...)
  # end
end
