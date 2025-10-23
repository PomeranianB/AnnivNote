class Post < ApplicationRecord

  belongs_to :user
  has_one_attached :post_image

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

end
