# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#u = User.create(:f_name => 'Alex', :l_name => 'lollo', :email => 'toto@coinvest.com', :password => '123456')



a = []

10.times do 
  user = User.create(:email => Faker::Internet.email,
                      :password => Faker::Name.name,
                      :f_name => Faker::Name.first_name,
                      :l_name => Faker::Name.last_name,
                      :adress => Faker::Address.street_name,
                      :credits => rand(500))
  a << user;
  print 'Creating ' + user.to_s
end

i = 1

10.times do 
  if rand(3) == 1
    print 'AYAYYAYAY'*9
    p = Project.create(:title => Faker::Company.name.gsub(/[^0-9A-Za-z]/, ''), 
                       :wish_money => rand(5000), 
                       :min_money => 1000, 
                       :date_end_wish => Date.today + rand(12), 
                       :capital_stock_type => true, 
                       :submited => true, 
                       :validated => true, 
                       :progress => rand(80),
                       :short_descr => Faker::Lorem.sentence(rand(10)),
                       :description => Faker::Lorem.paragraph(rand(6)),
                       :you_tube => 'http://www.youtube.com/watch?v=dact-1Tdgz0',
                       :project_image => File.open(File.join(Rails.root, '/db/seed/' + i.to_s + '.jpg')))
  else
    p = Project.create(:title => Faker::Company.name.gsub(/[^0-9A-Za-z]/, ''), 
                       :wish_money => rand(5000), 
                       :min_money => 1000, 
                       :date_end_wish => Date.today + rand(12), 
                       :capital_stock_type => true, 
                       :submited => true, 
                       :validated => true, 
                       :progress => rand(80),
                       :short_descr => Faker::Lorem.sentence(rand(10)),
                       :description => Faker::Lorem.paragraph(rand(6)),
                       :project_image => File.open(File.join(Rails.root, '/db/seed/' + i.to_s + '.jpg')))
  end
  i += 1
  print 'Creating ' + p.to_s + '\n'
  if p.errors.size > 0
    print 'Error : ' + p.errors.messages.to_s
  end
  ProjectUser.create(:user => a[rand(10)], :project => p)
end

10.times do 
  p = Project.create(:title => Faker::Company.name.gsub(/[^0-9A-Za-z ]/, ''), 
                     :wish_money => rand(5000), 
                     :min_money => 1000, 
                     :date_end_wish => Date.today + rand(12), 
                     :capital_stock_type => false, 
                     :personalized_reward => true,
                     :submited => true, 
                     :validated => true, 
                     :progress => rand(80),
                     :short_descr => Faker::Lorem.sentence(rand(10)),
                     :description => Faker::Lorem.paragraph(rand(150)),
                     :project_image => File.open(File.join(Rails.root, '/db/seed/' + i.to_s + '.jpg')))
  i += 1
  print 'Creating ' + p.to_s + '\n'
  if p.errors.size > 0
    print 'Error : ' + p.errors.messages.to_s
  end
  ProjectUser.create(:user => a[rand(10)], :project => p)
end

#

