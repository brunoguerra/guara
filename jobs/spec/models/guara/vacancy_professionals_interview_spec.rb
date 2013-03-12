require 'spec_helper'

describe VacancyProfessionalsInterview do
  
  
  before do
    @interview = VacancyProfessionalsInterview.new()
  end
  
  subject(@interview)
  
  it { should respond_to(:vacancy_scheduling_professional) }
  it { should respond_to(:date) }
  it { should respond_to(:process_instance) }
  it { should respond_to(:step) }
  
  it { VacancyProfessionalsInterview.should respond_to(:custom_process) }
  
end
