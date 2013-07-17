desc 'ignore missing migrations'
task ignore_migrations: :environment do

  files = Dir.glob("db/migrate/*")
  only_n_first_migrations = files.collect{|f| f.split("/").last.split("_").first}

  only_n_first_migrations.each do |version|
    sql = "select * from schema_migrations where version = '#{version}'"
    res = ActiveRecord::Base.connection.execute(sql) 
    
    if res.count == 0
      puts version
      sql = "insert into schema_migrations (version) values ('#{version}')"
      ActiveRecord::Base.connection.execute(sql) rescue nil
    end
  end

end
