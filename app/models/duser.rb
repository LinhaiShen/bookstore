class Duser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum group: {sysadmin:0, orderadmin:1, worker:2}
  has_and_belongs_to_many :roles, -> { alphabetical }
  def sysadmin?
    if self.roles.exists?(name: "sysadmin")
      true
    else
      false
    end
  end
end
