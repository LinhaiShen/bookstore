class Duser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum group: {sysadmin:0, orderadmin:1, worker:2}
  def sysadmin?
    if group == 'sysadmin'
      true
    else
      false
    end
  end
end
