Trestle.resource(:book_order_lines) do
  menu do
    group :Operations do
      item :book_order_lines, icon: "fa fa-list"
    end
  end

  form dialog: true do
    select :book_order_id, BookOrder.all
    text_field :linenumber
    select :book_id, Book.all
    text_field :qty
    select :status, BookOrder::STATUSES
    row do
     col { datetime_field :updated_at }
     col { datetime_field :created_at }
    end
  end

  table do
    column :book_order
    column :linenumber
    column :book
    column :qty
    column :status do |book_order_line|
      status_tag(book_order_line.status, { "fulfilled" => :info,"cancelled" => :danger }[book_order_line.status] || :default)
    end
    actions do |toolbar, instance, admin|
     toolbar.edit if admin && admin.actions.include?(:edit) if instance.status.in?(["created","cancelled"])
     toolbar.delete if admin && admin.actions.include?(:destroy) if instance.status.in?(["created","cancelled"])
     toolbar.link 'Fulfill', instance, action: :fulfill, method: :post, style: :primary, icon: "fa fa-truck-loading" if instance.status == "created"
     toolbar.link 'Cancel', instance, action: :cancel, method: :post, style: :primary, icon: "fa fa-ban" if instance.status == "created"
    end
  end

  controller do
    def fulfill
      line = admin.find_instance(params)
      line.update(status: "fulfilled")
      flash[:message] = "Order Line <" + line.linenumber.to_s + "> fulfilled!"
      redirect_to BookOrderLinesAdmin.path
    end
    def cancel
      line = admin.find_instance(params)
      line.update(status: "cancelled")
      flash[:message] = "Order Line <" + line.linenumber.to_s + "> cancelled!"
      redirect_to BookOrderLinesAdmin.path
    end
  end

  

  routes do
    post :fulfill, on: :member
    post :cancel, on: :member
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
  # form do |book_order_line|
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
  #   params.require(:book_order_line).permit(:name, ...)
  # end
end
