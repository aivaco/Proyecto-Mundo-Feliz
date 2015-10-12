class Cliente < ActiveRecord::Base
  belongs_to :persona
  has_one :portafolio, dependent: :destroy
  
  validates :nombreEmp, presence: true
end
