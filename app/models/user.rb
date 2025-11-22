class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :profile_image
  has_many :post_comments, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy
  has_many :owned_groups, class_name: "Group", foreign_key: 'owner_id' 
  has_many :permits, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
 
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end
  
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end
 
  def self.guest
    guest = find_by(email: "guestuser@example.com")
    guest.destroy if (guest)
    
    find_or_create_by!(email: "guestuser@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "GuestUser"
    end
    

  end

end