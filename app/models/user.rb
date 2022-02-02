class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :todos
  
  after_destroy :destroy_coupon_codes

   private

   def destroy_coupon_codes
     self.todos.destroy_all
   end
end
