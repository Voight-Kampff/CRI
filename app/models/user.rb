class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :kpis, :through => :kpisets
  has_many :inputsets, dependent: :destroy
  has_many :kpisets, dependent: :destroy
  has_many :inputs, :through => :inputsets
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_sets, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


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

  def assigned_inputset_feed
    Inputset.where("user_id = ?", id)
  end

  def assigned_kpiset_feed
    Kpiset.where("user_id = ?", id)
  end

  def following?(kpiset)
    relationships.find_by_followed_id(kpiset.id)
  end

  def follow!(kpiset)
    relationships.create(followed_id: kpiset.id)
  end

  def unfollow!(kpiset)
    relationships.find_by_followed_id(kpiset.id).destroy
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
