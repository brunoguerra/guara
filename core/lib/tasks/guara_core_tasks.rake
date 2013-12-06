# desc "Explaining what the task does"
# task :guara_core do
#   # Task goes here
# end
#

require 'guara/rake'

Rake.application.remove_task 'guara:install'

namespace :guara do
  
  desc "Running migrate task"    
  task migrate: :environment do
    execute_task 'guara:install:migrations'
    execute_task 'db:migrate'
  end
  
  desc "Install Guara Core"      
  task install: :environment do
    execute_task 'guara:migrate'
    Guara::Core::Engine.load_seed
  end

  namespace :install do
    desc "Install Basic Users to access - administrator and tester"      
    task users: :environment do
      if Guara::User.where(name: 'Administrador').count==0
        Guara::User.create!(
          name: "Administrador",
          email: "adm@adm.com",
          admin: true,
          password: "admini",
          password_confirmation: "admini"
        )
        Guara::User.create!(
          name: "Testador",
          email: "test@test.com",
          password: "testes",
          password_confirmation: "testes"
        )
      end
    end
  end
  
  namespace :db do
    
    desc "Feed db whith guara core seed"    
    task seeds: :environment do
      Guara::Core::Engine.load_seed
    end

    desc "Fill database with sample data"
    task sample: :environment do
      require 'faker'
      begin    
        logger =  Logger.new(STDOUT)
        Faker::Config.locale = [:en]
    
        Guara::User.where(admin:false).each do |u|
          u.destroy_fully()
        end
    
        Guara::Micropost.destroy_all()
    
        Guara::User.create!(name: "Teste User",
                         email: "teste@teste.com",
                         password: "testes",
                         password_confirmation: "testes")

        8.times do |n|
          name  = "#{Faker::Name.name} Gen #{n} "[0..24]

          logger.info name
          email = "example-#{n+1}@guaracrm.org"
          password  = "password"
          Guara::User.create!(name: name,
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
        puts exception.message
        Rails.logger.error("Message for the log file #{exception.message}\n\n")
        Rails.logger.info exception.backtrace.to_yaml
      end
    end
  
    #TODO: pegar parametros do rake
    task add_user_privilegie: :environment do
      User.where("email like ?", '%test%')[0].abilities.build(:module => SystemModule.CUSTOMER, :ability => SystemAbility.UPDATE).save
    end
  end
end

namespace :db do
  desc 'task to rebuild db test'
  task :rebuild do
    Rails.env='test'
    Rake::Task["environment"].invoke

    begin
      execute_task 'db:drop'
      execute_task 'db:create'
      execute_task 'db:migrate'
      execute_task 'db:seed'
    rescue Exception => e
      puts e.message
      puts e.class.name
    end

  end
end