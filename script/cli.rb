puts "Input your email:"
email = gets.chomp

u = User.new(email: email)
u.save!

puts "What do you want to do?"
puts "0. Create shortened URL"
puts "1. Visit shortened URL"

action = gets.chomp.to_i
if action == 0
  puts "Type in your long url"
  long_url = gets.chomp
  short_url = ShortenedUrl.create_for_user_and_long_url!(u, long_url)
  short_url.save!
  puts "Short url is: #{short_url.short_url}"
else
  puts "Type in the shortened URL"
  short_url = gets.chomp
  s = ShortenedUrl.find_by_short_url(short_url)
  long_url = s.long_url
  Launchy.open (long_url)
end