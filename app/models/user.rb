class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_id, :unconfirmed_email
  before_save :ensure_authentication_token
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :token_authenticatable
  belongs_to :role

  def skip_confirmation!
    self.confirmed_at = Time.now
  end

end
