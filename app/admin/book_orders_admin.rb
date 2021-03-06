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
      
    BookOrder.statuses.to_a.each do |stat|
        scope stat[0], -> { BookOrder.where(status: stat[0]) }
    end
  end

  table do
    column :id
    column :refnumber
    column :status
    column :deliverytime
    column :deliveryaddress
    column :notes
    column :assignee
    actions do |toolbar, instance, admin|
      toolbar.link 'Order PDF', admin.path(:show, id: instance.id, format: :pdf), method: :get, style: :dark, icon: "fa fa-file-pdf"
    end
  end

  form do
    tab :book_order do
      row do
        text_field :id,:readonly => true
        text_field :refnumber
        select :status, BookOrder.statuses.keys
       select :assignee_id, Duser.all, include_blank: true
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
      concat admin_link_to("New Line", admin: :book_order_lines, action: :new, params: { book_order_id: instance.id }, class: "btn btn-success")
    end
  end

  controller do
    def show
      respond_to do |format|
        format.html { render :show }
        format.pdf do
          data_array ||= []
          data_array << ["linenumber","status","book","qty"]
          instance.book_order_lines.each do |line|
            data_array << [line.linenumber, line.status, line.book.name, line.qty]
          end
          pdf = Prawn::Document.new
          pdf.font("vendor/assets/fonts/msyhl.ttc")
          pdf.table(data_array, header: true)
          pdf.bounding_box([pdf.bounds.left, pdf.bounds.bottom], :width => pdf.bounds.width, :height => 30) {
          pdf.number_pages "<page> of <total>"
          }
          send_data pdf.render,
            filename: "export.pdf",
            type: 'application/pdf',
            disposition: 'inline'
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
