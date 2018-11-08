#Normal User
Category.all.each do |c|
  Topic.seed do |tp|
    tp.title = Faker::Lorem.sentence
    tp.category_id = c.id
    tp.creator_id = User.first.id
  end
end

Topic.all.each do |tp|
  Post.seed do |p|
    p.topic_id = tp.id
    p.content = Faker::Lorem.paragraph(2)
    p.user_id = User.ids.sample
  end
end
