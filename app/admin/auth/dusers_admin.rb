Trestle.resource(:dusers, model: Duser, scope: Auth) do
  before_action do
    unless current_user.sysadmin?
      flash[:error] = "Administrator access required."
      redirect_to Trestle.config.path
    end
  end

  menu do
    group :configuration, priority: :last do
      item :dusers, icon: "fa fa-users"
    end
  end

  table do
    column :avatar, header: false do |administrator|
      avatar_for(administrator)
    end
    column :email, link: true
    actions do |a|
      a.delete unless a.instance == current_user
    end
  end

  form do |administrator|
    text_field :email
    select :group, ["sysadmin","orderadmin","worker"]

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
