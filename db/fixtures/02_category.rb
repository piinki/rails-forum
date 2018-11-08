#Normal User
categories = ["Game", "Showbiz", "Technical", "Car", "Food"]

categories.each do |c|
  Category.seed do |s|
    s.title = c
    s.permission_view = 0
    s.status = 0
  end
end
