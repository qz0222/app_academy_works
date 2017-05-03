puts "test test"
puts "Input your email:"

user_email = gets.chomp
if User.where('email = ?', user_email).length > 0
  this_user = User.where('email = ?', user_email)[0]
  puts "welcome, back"
  puts ""
else
  this_user = User.create!(email:user_email)
end
puts "What do you want to do?
0. Create shortened URL
1. Visit shortened URL"
begin
  selection = gets.chomp
  raise "" unless ["0","1"].include?(selection)
rescue
  puts  "please enter 0 or 1"
  retry
end

if selection == "0"
  puts "Type in your long url"
  this_long_url = gets.chomp
  if ShortenedUrl.where('long_url = ?', this_long_url).length > 0
    shortened = ShortenedUrl.where('long_url = ?', this_long_url)[0].short_url
  else
    shortened = ShortenedUrl.make(this_user, this_long_url).short_url
  end
  puts "Short url is: #{shortened}"
  puts "Goodbye!"
else
  puts "Type in the shortened URL"
  this_short_url = gets.chomp
  if ShortenedUrl.where('short_url = ?', this_short_url).length > 0
    long = ShortenedUrl.where('short_url = ?', this_short_url)[0].long_url
    puts "Launching #{long}..."
    Launchy.open(long)
    Visit.record_visit!(this_user,this_short_url)

    puts "Goodbye!"

  else
    puts "invalid input"
  end
end
