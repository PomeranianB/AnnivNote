class UserImage < ApplicationRecord
  t.string :name
  t.text :introduction
  t.integer :user_id

  has_one_attached :image
  belongs_to :user
end
