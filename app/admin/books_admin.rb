Trestle.resource(:books) do
  menu do
    group :Operations do
    item :books, icon: "fa fa-book"
    end
  end

  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end
table do
   column :name
   column :author
   column :isbn, header: 'ISBN'
   column :numberofpages, header: 'Number of Pages'
   actions do |toolbar, instance, admin|
    toolbar.edit if admin && admin.actions.include?(:edit)
    toolbar.delete if admin && admin.actions.include?(:destroy)
    toolbar.link 'Order', instance, action: :orderbook, method: :post, style: :primary, icon: "fa fa-plus-circle"
   end
 end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |book|
  #   text_field :name
  #
  #   row do
  #     col { datetime_field :updated_at }
  #     col { datetime_field :created_at }
  #   end
  # end
form do |book|
  row do
     col { text_field :name }
     col { text_field :author }
     col { text_field :isbn }
     col { static_field :updated_at }
     col { static_field :created_at }
   end
 end

controller do
  def orderbook
    book = admin.find_instance(params)
    #bookorderline = BookOrderLine.create(linenumber:Time.now.yday,book:book, status:"created",qty:1)
    if BookOrderLine.where(book:book,status:"created").exists?
      bookorderline = BookOrderLine.where(book:book,status:"created")
      currentqty = bookorderline[0]["qty"]
      bookorderline.update(qty: currentqty + 1)
    else
      bookorderline = BookOrderLine.create(linenumber:Time.now.yday,book:book, status:"created",qty:1)
    end
    flash[:message] = "1 book of <" + book.name + "> ordered!"
    redirect_to BookOrderLinesAdmin.path
  end
end

routes do
  post :orderbook, on: :member
end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:book).permit(:name, ...)
  # end
end
