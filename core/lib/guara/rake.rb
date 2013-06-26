require 'rake'

def execute_task task
  t = Rake::Task[task]
  puts "starting #{task} #{t} (by caller #{caller[0]})"
  Rake::Task["railties:install:migrations"].reenable
  t.reenable
  r = t.invoke
  puts "#{task} done! #{r}"
end


Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end
