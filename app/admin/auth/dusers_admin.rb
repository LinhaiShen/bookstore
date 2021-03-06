Trestle.resource(:dusers, model: Duser, scope: Auth) do
  before_action do
    unless current_user.sysadmin?
      flash[:error] = "Administrator access required."
      redirect_to Trestle.config.path
    end
  end

  menu do if current_user.sysadmin?
    group :configuration, priority: :last do
      item :dusers, icon: "fa fa-users"
    end
  end
  end

  scopes do
    #scope :sysadmin
    Duser.tag_counts_on(:privileges).each do |p|
      scope p.name, -> { Duser.tagged_with(p.name, on: :privileges) }
  end
  end

  table do
    column :avatar, header: false do |administrator|
      avatar_for(administrator)
    end
    column :email, link: true
    column :name
    actions do |a|
      a.delete unless a.instance == current_user
    end
  end

  form do |duser|
    text_field :email
    text_field :name
    #select :group, ["sysadmin","orderadmin","worker"]
    tag_select :privilege_list
    select :role_ids, Role.alphabetical.map { |c|[c.name, c.id] }, { label: "Role" }, multiple: true

    row do
      col(sm: 6) { password_field :password }
      col(sm: 6) { password_field :password_confirmation }
    end
  end

  update_instance do |instance, attrs|
    if attrs[:password].blank?
      attrs.delete(:password)
      attrs.delete(:password_confirmation) if attrs[:password_confirmation].blank?
    end

    instance.assign_attributes(attrs)
  end

  after_action on: :update do
    if Devise.sign_in_after_reset_password && instance == current_user
      login!(instance)
    end
  end
end
