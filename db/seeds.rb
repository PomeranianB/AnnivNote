#管理者

  Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
    admin.password = 'password'
  end

#ユーザー

  Alice = User.find_or_create_by!(email: "alice@example.com") do |user|
    user.name = "Alice"
    user.password = "passwordalice"
    user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/alice_prf.jpg"), filename:"alice_prf.jpg")
  end

  Belle = User.find_or_create_by!(email: "belle@example.com") do |user|
    user.name = "Belle"
    user.password = "passwordbell"
    user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/belle_prf.jpg"), filename:"belle_prf.jpg")
  end

#post

  Post.find_or_create_by!(title: "七五三") do |post|
    post_id = 1
    post.post_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/shichigosan.jpeg"), filename:"shichigosan.jpeg")
    post.body = "男の子なので三歳で七五三を行うか迷っていましたが、実際やってみてよかったです！被布は今だけなので三歳らしくてかわいい！"
    post.user = Alice
  end