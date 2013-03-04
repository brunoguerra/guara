 
module Guara
  module Jobs
    module ActiveProcess
      describe ProcessBusinesssObject do
  
        before { @bo = ProcessComponent.new }
        
        subject (@bo)
      
        it { should respond_to(:index) }
      end
    end
  end
end
  