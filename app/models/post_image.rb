class PostImage < ApplicationRecord
  t.string :title
  t.text :body
  t.integer :post_id

  belongs_to :post
  has_one_attached :image

end
