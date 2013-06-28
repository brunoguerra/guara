# encoding: UTF-8
class AddStepCustomerValidation < ActiveRecord::Migration
  	def up
	  	@custom_process = Guara::Jobs::CustomProcess.find_by_name('vacancy')
	  	@step_init = @custom_process.step
	  	@new_step = @custom_process.create_step(
	  		:name=> 'Validar com Cliente', 
	  		:next=> @step_init.next,
	  		:custom_process_id=> @custom_process.id
	  	)

	  	update_levels()
	  	create_step_attrs()
  	end

  	def update_levels()
	  	@step_init.update_attribute('next', @new_step.id)
	  	
	  	@custom_process.steps.where('level > 0').each do |step|
	  		step.update_attribute(:level, (step.level + 1))
	  	end

	  	@new_step.update_attribute(:level, 1)
  	end

  	def create_step_attrs()
	  	@new_step.attrs.create(
	  		title: 'Data da Validação',
		  	type_field: 'date',
		  	resume: true,
		  	required: true,
		  	column: 1,
		  	position: 0
	  	)

	  	@new_step.attrs.create(
	  		title: 'Responsável',
		  	type_field: 'select',
		  	options: 'model_eval:/ProcessInstance.find(params[:id]).vacancy.customer_pj.person.contacts/',
		  	resume: true,
		  	required: true,
		  	column: 1,
		  	position: 1
	  	)

	  	@new_step.attrs.create(
	  		title: 'Notas',
		  	type_field: 'text_area',
		  	resume: true,
		  	required: true,
		  	column: 1,
		  	position: 2
	  	)

	  	@new_step.attrs.create(
	  		title: 'Enviar Validação por Email',
		  	type_field: 'widget',
		  	widget: 'send_validation_customer',
		  	resume: false,
		  	required: false,
		  	column: 1,
		  	position: 3
	  	)
	end
end
