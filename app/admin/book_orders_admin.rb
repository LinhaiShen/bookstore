Trestle.resource(:book_orders) do
  menu do
    group :Operations do
    item :book_orders, icon: "fa fa-file-alt"
    end
  end

  search do |query|
    if query
      BookOrder.where("id LIKE ? OR refnumber LIKE ?", "%#{query}%", "%#{query}%")
    else
      BookOrder.all
    end
  end

  scopes do
    scope :all
    scope :open , default: true
    scope :today
    scope :assigned
    scope :unassigned
  end

  form do
    tab :book_order do
      row do
        text_field :id,:readonly => true
        text_field :refnumber
        select :status, BookOrder::STATUSES
        select :assignee_id, Duser.all
      end
      text_field :deliveryaddress
      text_field :notes
    end
    
    tab :lines, badge: BookOrderLine.where(book_order: instance.id).size do
      table BookOrderLine.where(book_order: instance.id) do
        column :itself
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
