class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :post_image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  scope :with_active_user, -> {joins(:user).where(users:{is_valid: true})}

  def get_post_image
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/NO_IMAGE.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [200, 200]).processed
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%'+content)
    else
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end