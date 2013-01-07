#encoding: utf-8
module Guara
  begin
    SystemTaskStatus.create([
                             { name: "OPENED" },
                             { name: "IN_PROGRESS" },
                             { name: "PAUSED" },
                             { name: "CLOSED" },
                           ])

    SystemTaskResolution.create([
                              { name: "RESOLVED" },
                              { name: "CANCELED" },
                              { name: "BLOCKED" },
                           ])
                         
    SystemTaskResolution.create([
                              { name: "RESOLVED_WITH_BUSINESS", parent_id: SystemTaskResolution.find_by_name("RESOLVED").id }
                          ])

     #segmento
     BusinessSegment.create(name:'Segmento Padrão')

     #atividade
     BusinessActivity.create(name:'Atividade Padrão')

     #Administração
     BusinessDepartment.create([
                         { name: "Administração" },
                         { name: "RH" }
                       ])
                     
     SystemModule.create([
                          { name: 'Customer' },
                          { name: 'Contact' },
                          { name: 'CustomerPj' },
                          { name: 'CustomerPf' },
                          { name: 'BusinessActivity' },
                          { name: 'BusinessSegment' },
                          { name: 'BusinessActivity' },
                          { name: 'Contact' },
                          { name: 'Task' },
                       ])

  rescue Exception => exception
    logger =  Logger.new(STDOUT)
    if exception.respond_to?(:record) && !exception.record.nil?
      logger.error("Error running task db:seed - #{exception.message} #{exception.class} #{exception.record.to_yaml}\n#{exception.record.errors.to_yaml}\n\n")
    else
      logger.error("Error running task db:seed - #{exception.message} #{exception.class}\n\n")
    end
    logger.info exception.backtrace.to_yaml
  end
end