class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :inputs
  has_many :kpis

  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token 

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    # This is only a proto-feed.
    Micropost.where("user_id = ?", id)
  end

  def input_feed
    Input.where("user_id =? AND admin = ?", id, true)
  end
  
  def kpi_feed
    Kpi.where("user_id =? AND admin = ?", id, true)
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
