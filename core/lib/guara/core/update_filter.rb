module Guara
  module UpdateFilter
    def before_update_filter(callback_method, options = {})
      puts self # class scope
      self.set_callback :save, :before do
        puts self # instance scope
        # check if all of the listed attributes have changed
        if options[:attr_params].map{ |attr| attribute_changed?(attr) }.all?
          # call instance method
          send callback_method
        end
      end
    end
  end
end