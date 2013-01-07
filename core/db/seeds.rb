#encoding: utf-8

module Guara
  begin
    SystemAbility.create([{ id:1, name: 'CREATE' }, { id:2, name: 'READ' }, { id:3, name: 'UPDATE' }, { id:4, name: 'DELETE' }])
    
    SystemModule.create([
                         { name: 'all' },
                         { name: 'User' },
                         { name: 'Micropost' },
                         { name: 'State' },
                         { name: 'City' },
                         { name: 'District' },
                      ])                   

    admin_group = UserGroup.create!(name: "Administrators", system: true)

    admin = User.create!(name: "Adm Sistema",
                        email: "adm@adm.com",
                        password: "admini",
                        password_confirmation: "admini")

    admin.toggle!(:admin)

    admin.primary_group = admin_group

    admin.save

    admin_group.abilities.build(:ability => SystemAbility.CREATE,  :module => SystemModule.ALL)
    admin_group.abilities.build(:ability => SystemAbility.READ,    :module => SystemModule.ALL)
    admin_group.abilities.build(:ability => SystemAbility.UPDATE,  :module => SystemModule.ALL)
    admin_group.abilities.build(:ability => SystemAbility.DELETE,  :module => SystemModule.ALL)
    
    admin_group.save
    
    ### States

    State.create  ([
                      { acronym: "AC", name: "Acre"},
                      { acronym: 'AL', name: 'Alagoas' },
                      { acronym: 'AM', name: 'Amazonas' },
                      { acronym: 'AP', name: 'Amapá' },
                      { acronym: 'BA', name: 'Bahia' },
                      { acronym: 'CE', name: 'Ceará' },
                      { acronym: 'DF', name: 'Distrito Federal' },
                      { acronym: 'ES', name: 'Espírito Santo' },
                      { acronym: 'GO', name: 'Goiás' },
                      { acronym: 'MA', name: 'Maranhão' },
                      { acronym: 'MG', name: 'Minas Gerais' },
                      { acronym: 'MS', name: 'Mato Grosso do Sul' },
                      { acronym: 'MT', name: 'Mato Grosso' },
                      { acronym: 'PA', name: 'Pará' },
                      { acronym: 'PB', name: 'Paraíba' },
                      { acronym: 'PE', name: 'Pernambuco' },
                      { acronym: 'PI', name: 'Piauí' },
                      { acronym: 'PR', name: 'Paraná' },
                      { acronym: 'RJ', name: 'Rio de Janeiro' },
                      { acronym: 'RN', name: 'Rio Grande do Norte' },
                      { acronym: 'RR', name: 'Roraima' },
                      { acronym: 'RO', name: 'Rondônia' },
                      { acronym: 'RS', name: 'Rio Grande do Sul' },
                      { acronym: 'SC', name: 'Santa Catarina' },
                      { acronym: 'SE', name: 'Sergipe' },
                      { acronym: 'SP', name: 'São Paulo' },
                      { acronym: 'TO', name: 'Tocantins' },
                  ])


    ### City
    City.create( name: 'FORTALEZA', state: State.find_by_acronym('CE') )
  
  
  
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