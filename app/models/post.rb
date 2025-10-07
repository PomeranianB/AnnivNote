class Post < ApplicationRecord

  belongs_to :user
  has_many_attached :post_images

  validates :title, presence: true
  validates :body, presence: true

  def get_post_image
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [100, 100]).processed
  end

end
