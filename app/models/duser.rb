class Duser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum group: {sysadmin:0, orderadmin:1, worker:2}
  has_and_belongs_to_many :roles, -> { alphabetical }
  
  def active_for_authentication?
    super && account_active?
  end
  
  def inactive_message
    account_active? ? super : :limit_reached
  end

  def account_active?
    if Location.all.size >= id.to_i && !sysadmin?
      false
    else
      true
    end
    true
  end

  def sysadmin?
    if self.roles.exists?(name: "sysadmin")
      true
    else
      false
    end
    true
  end
end
