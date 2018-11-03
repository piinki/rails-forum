#Normal User
categories = ["Game", "Showbiz", "Technical", "Car", "Food"]

categories.each do |c|
  Category.seed do |s|
    s.title = c
  end
end
