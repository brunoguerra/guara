#encoding: utf-8
module Guara
	begin
		module Jobs

			BusinessAction.create([
					{ name: "TECNOLOGIA DE INFORMACAO - TI" },
					{ name: "RECURSOS HUMANOS" }
			])

	CustomProcess.create([
            {:id=> 1,:name=> 'vacancy',:hook_instanciate=> 'Guara::Jobs::VacancyProcessHook',:business_id=> nil,:step_init=> 1,:enabled=> true},
            {:id=> 2,:name=> 'professionals_interview',:hook_instanciate=> 'Guara::Jobs::VacancyProcessHook',:business_id=> nil,:step_init=> 5,:enabled=> true}
      ])

        Step.create([
      {:id=> 1,:name=> 'Abertura de Vaga',:next=> 2,:level=> 0,:custom_process_id=> 1},
      {:id=> 2,:name=> 'Validar Perfil com Cliente',:next=> 3,:level=> 1,:custom_process_id=> 1},
      {:id=> 3,:name=> 'Divulgar Vaga',:next=> 4,:level=> 2,:custom_process_id=> 1},
      {:id=> 4,:name=> 'Triar Curriculos',:next=> 7,:level=> 3,:custom_process_id=> 1},
      {:id=> 5,:name=> 'Entrevistar Candidatos',:next=> nil,:level=> 0,:custom_process_id=> 2},
      {:id=> 6,:name=> 'Entrevistar Candidatos',:next=> 8,:level=> 5,:custom_process_id=> 1},
      {:id=> 7,:name=> 'Recrutar Candidatos',:next=> 6,:level=> 4,:custom_process_id=> 1},
      {:id=> 8,:name=> 'Enviar ao Cliente',:next=> nil,:level=> 6,:custom_process_id=> 1}
  ])

    StepAttr.create([
      {:id=> 1023,:title=> 'Roteiro de Entrevista',:position=> '0',:options=> 'Seleção, Avaliação',:widget=> '',:group=> '',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1024,:title=> 'Caixa de Seleção',:position=> '1',:options=> '$Guara::Jobs::Consultant',:widget=> '',:group=> '',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1025,:title=> 'Data',:position=> '2',:options=> '',:widget=> '',:group=> '',:type_field=> 'date',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1026,:title=> 'Retrospecto Profissional',:position=> '3',:options=> '',:widget=> '',:group=> '',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1027,:title=> 'Pretensão Salarial',:position=> '4',:options=> '',:widget=> '',:group=> '',:type_field=> 'price',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1028,:title=> 'Último Emprego',:position=> '5',:options=> '',:widget=> '',:group=> 'Referências Profissionais',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1029,:title=> 'Telefone',:position=> '6',:options=> '',:widget=> '',:group=> 'Referências Profissionais',:type_field=> 'phone',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1030,:title=> 'Contato',:position=> '7',:options=> '',:widget=> '',:group=> 'Referências Profissionais',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1031,:title=> 'Cargo',:position=> '8',:options=> '',:widget=> '',:group=> 'Referências Profissionais',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1032,:title=> 'Penúltimo Emprego',:position=> '9',:options=> '',:widget=> '',:group=> 'Referências Profissionais',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1033,:title=> 'Telefone',:position=> '10',:options=> '',:widget=> '',:group=> 'Referências Profissionais',:type_field=> 'phone',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1034,:title=> 'Contato',:position=> '11',:options=> '',:widget=> '',:group=> 'Referências Profissionais',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1035,:title=> 'Cargo',:position=> '12',:options=> '',:widget=> '',:group=> 'Referências Profissionais',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1036,:title=> 'Como você se Percebe?',:position=> '13',:options=> '',:widget=> '',:group=> 'Auto Percepção',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1037,:title=> 'Pontos Fortes/a Melhorar',:position=> '1',:options=> '',:widget=> '',:group=> 'Auto Percepção',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1038,:title=> 'Relacionamento com os outros',:position=> '2',:options=> '',:widget=> '',:group=> 'Auto Percepção',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 18,:title=> 'Perfil aprovado pelo cliente',:position=> '0',:options=> 'Sim, Não',:widget=> '',:group=> nil,:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 2},
      {:id=> 19,:title=> 'Observação',:position=> '1',:options=> '',:widget=> '',:group=> nil,:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 2},
      {:id=> 20,:title=> 'Meio de Divulgação',:position=> '0',:options=> 'Internet, Telejornal, Classificados',:widget=> '',:group=> nil,:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 3},
      {:id=> 21,:title=> 'Como foi a Divulgação',:position=> '1',:options=> '',:widget=> '',:group=> nil,:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 3},
      {:id=> 1039,:title=> 'Organização diante das várias atividades no trabalho',:position=> '16',:options=> '',:widget=> '',:group=> 'Auto Percepção',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1040,:title=> 'Profissional que serviu de modelo? Por que?',:position=> '17',:options=> '',:widget=> '',:group=> 'Auto Percepção',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1041,:title=> 'Algum problema sério ultimamente?',:position=> '18',:options=> '',:widget=> '',:group=> 'Saúde',:type_field=> 'text',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 101,:title=> 'Fuma?',:position=> '19',:options=> 'Sim, Não',:widget=> '',:group=> 'Saúde',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 102,:title=> 'Bebe?',:position=> '20',:options=> 'Sim, Não',:widget=> '',:group=> 'Saúde',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 103,:title=> 'Estado Civil',:position=> '21',:options=> 'Solteiro, Casado, Outros',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 104,:title=> 'Estado Civil (Outros)',:position=> '22',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 107,:title=> 'Profissão do Pai',:position=> '23',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 105,:title=> 'Profissão da Mãe',:position=> '24',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1048,:title=> 'Tempo (Casado)',:position=> '25',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 22,:title=> 'Selecionar Profissionais',:position=> '0',:options=> '$Guara::Jobs::Professional',:widget=> 'selecionar_candidatos',:group=> nil,:type_field=> 'widget',:resume=> true,:required=> true,:column=> 1,:step_id=> 4},
      {:id=> 24,:title=> 'Customização de Campo',:position=> '0',:options=> 'component',:widget=> 'Guara::Jobs::VacancySendedProfessionalsController',:group=> nil,:type_field=> 'widget',:resume=> true,:required=> true,:column=> 1,:step_id=> 8},
      {:id=> 1049,:title=> 'Profissão do Conjugue',:position=> '26',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 108,:title=> 'Quantidade de Filhos',:position=> '27',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1051,:title=> 'Sexo/Idades',:position=> '28',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1052,:title=> 'Com quem reside?',:position=> '29',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1053,:title=> 'Residência',:position=> '30',:options=> 'Própria, Alugada, Financiada',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1054,:title=> 'Relacionamento Familiar',:position=> '31',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1055,:title=> 'Participa de alguma atividade social?',:position=> '32',:options=> '',:widget=> '',:group=> 'Vida Familiar e Social',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 106,:title=> 'Rendimentos Mensais Atuais (Aprox.)',:position=> '33',:options=> '',:widget=> '',:group=> 'Situação Econômica',:type_field=> 'price',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1057,:title=> 'Ajuda Financeiramente em Casa?',:position=> '34',:options=> 'Sim, Não',:widget=> '',:group=> 'Situação Econômica',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1058,:title=> 'Alguém mais trabalha em casa?',:position=> '35',:options=> 'Sim, Não',:widget=> '',:group=> 'Situação Econômica',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1059,:title=> 'Possui Veículo',:position=> '36',:options=> 'Sim, Não',:widget=> '',:group=> 'Situação Econômica',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1060,:title=> 'De maneira geral quais são seus planos para o futuro, quais são seus objetivos, mais importantes',:position=> '37',:options=> '',:widget=> '',:group=> 'Planos Prospectivos',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1061,:title=> 'Características',:position=> '38',:options=> 'Ancioso, Dissimulado, Depressão, Medo, Franco, Rígido, Rude, Vigor, Mágoa, Confiança, Cooperativo, Perspectivas',:widget=> '',:group=> 'impressões a respeito do candidato',:type_field=> 'select',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1062,:title=> 'Comunicação',:position=> '39',:options=> 'Fluente, Difícil Verbalização, Fácil e clara, Confusa, Razoável, Objetiva, Proxila, Gagueira',:widget=> '',:group=> 'comunicação',:type_field=> 'select',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1063,:title=> 'Nível Intelectual',:position=> '40',:options=> 'De fácil compreensão, De difícil compreensão, De razoável compreensão, Ágil, Reflexivo, Intuitivo',:widget=> '',:group=> 'nível intelectual',:type_field=> 'select',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1064,:title=> 'Relacionamento Interpessoal',:position=> '41',:options=> 'Fácil, Difícil, Afável, Receptivo, Fechado, Discreto, Alegre bem humorado, Contraído, Polido',:widget=> '',:group=> 'relacionamento interpessoal',:type_field=> 'select',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1065,:title=> 'Físico / Postura',:position=> '1',:options=> 'Físico normal, Físico compatível com o cargo, Físico não compatível com o cargo',:widget=> '',:group=> 'Fisico_Postura',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1066,:title=> 'Motivo (não compatível)',:position=> '2',:options=> '',:widget=> '',:group=> 'Físico_Postura',:type_field=> 'text',:resume=> true,:required=> false,:column=> 1,:step_id=> 5},
      {:id=> 1067,:title=> 'Postura',:position=> '3',:options=> 'Boa apresentação pessoal, Apresentação pessoal inadequada, Postura adequada, Postura inadequada, Tremor',:widget=> '',:group=> 'Físico_Postura',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1068,:title=> 'Considerações gerais',:position=> '4',:options=> '',:widget=> '',:group=> 'Físico_Postura',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 5},
      {:id=> 1069,:title=> 'Recrutar',:position=> '0',:options=> 'component',:widget=> 'Guara::Jobs::SchedulerProfessionalsController',:group=> '',:type_field=> 'widget',:resume=> true,:required=> true,:column=> 1,:step_id=> 7},
      {:id=> 1071,:title=> 'Entrevistar Profissionais',:position=> '0',:options=> 'component',:widget=> 'Guara::Jobs::InterviewerProfessionalsController',:group=> '',:type_field=> 'widget',:resume=> true,:required=> false,:column=> 1,:step_id=> 6},
      {:id=> 1096,:title=> 'Motivo',:position=> '3',:options=> '',:widget=> '',:group=> '',:type_field=> 'text_area',:resume=> true,:required=> true,:column=> 1,:step_id=> 1},
      {:id=> 1097,:title=> 'Faixa Salarial - Inicio',:position=> '4',:options=> '',:widget=> '',:group=> '',:type_field=> 'price',:resume=> true,:required=> true,:column=> 1,:step_id=> 1},
      {:id=> 1098,:title=> 'Faixa Salarial - Fim',:position=> '5',:options=> '',:widget=> '',:group=> '',:type_field=> 'price',:resume=> true,:required=> true,:column=> 1,:step_id=> 1},
      {:id=> 1099,:title=> 'Empresa',:position=> '0',:options=> '$Guara::CustomerPj',:widget=> '',:group=> '',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 1},
      {:id=> 1100,:title=> 'Cargo',:position=> '1',:options=> '$Guara::Jobs::Role',:widget=> '',:group=> '',:type_field=> 'select',:resume=> true,:required=> true,:column=> 1,:step_id=> 1},
      {:id=> 1101,:title=> 'Tipo de Vaga',:position=> '2',:options=> 'Estágio, Free Lance, Efetivo',:widget=> '',:group=> '',:type_field=> 'select',:resume=> true,:required=> false,:column=> 1,:step_id=> 1}
  ])

		end


	    SystemModule.create([
			{ name: 'Professional' },
			{ name: 'BusinessActivity' },
			{ name: 'Role' },
			{ name: 'Consultant' },
			{ name: 'LevelEducation' },
			{ name: 'CustomProcess' },
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