# desc "Explaining what the task does"
# task :guara_core do
#   # Task goes here
# end
namespace :guara do
  namespace :db do
    
    task seeds: :environment do
      Guara::Core::Engine.load_seed
    end
    
    desc "Fill database with sample data"
    task sample: :environment do
      begin    
        Faker::Config.locale = [:en]
        logger =  Logger.new(STDOUT)
    
        User.where(admin:false).each do |u|
          u.destroy_fully()
        end
    
        Micropost.destroy_all()
    
        User.create!(name: "Teste User",
                         email: "teste@teste.com",
                         password: "testes",
                         password_confirmation: "testes")

        8.times do |n|
          name  = "#{Faker::Name.name} Gen #{n} "[0..24]

          logger.info name
          email = "example-#{n+1}@guaracrm.org"
          password  = "password"
          User.create!(name: name,
                       email: email,
                       password: password,
                       password_confirmation: password)
        end
    
        users = User.all(limit: 5)
        users[2..4].each do |user|
          26.times do
            content = Faker::Lorem.sentence(5)
            user.microposts.create!(content: content)
          end
        end
    
    
        def make_relationships
          users = User.all
          user  = users.first
          followed_users = users[2..5]
          followers      = users[3..7]
          followed_users.each { |followed| user.follow!(followed) }
          followers.each      { |follower| follower.follow!(user) }
        end
       
      rescue Exception => exception
        logger.error("Message for the log file #{exception.message}\n\n")
        logger.info exception.backtrace.to_yaml
      end
    end
  
    #TODO: pegar parametros do rake
    task add_user_privilegie: :environment do
      User.where("email like ?", '%test%')[0].abilities.build(:module => SystemModule.CUSTOMER, :ability => SystemAbility.UPDATE).save
    end
  end
end