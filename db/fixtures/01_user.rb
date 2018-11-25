#Normal User
5.times do |i|
  User.seed do |s|
    s.first_name = Faker::Name.first_name
    s.last_name = Faker::Name.last_name
    s.email = "user-#{i}@gmail.com"
    s.password = "123456"
  end
end

# Mod User

prefix_name = ["Mr", "Mrs"]

prefix_name.each do |p|
  User.seed do |s|
    s.first_name = p
    s.last_name = "Moderator"
    s.email = "#{p.downcase}.moderator@gmail.com"
    s.password = "123456"
    s.role = 1
  end
end



# Admin User


prefix_name.each do |p|
  User.seed do |s|
    s.first_name = p
    s.last_name = "Admin"
    s.email = "#{p.downcase}.admin@gmail.com"
    s.password = "123456"
    s.role = 2
  end
end
