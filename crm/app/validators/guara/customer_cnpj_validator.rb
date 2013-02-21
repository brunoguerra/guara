require 'brcpfcnpj'

module Guara
  class CustomerCnpjValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
    
      if (record.customer_type==CustomerPj.to_s)
      
        #cnpj
        unless (!record.complete? && ((value == "") || (value == '0'*14) || (Cnpj.new(value).valido?))) || 
               (::Cnpj.new(value).valido?)
          record.errors[attribute] << (options[:message] || ("%s %s" % [I18n.t("customer_pjs.doc"), I18n.t('errors.messages.invalid')]) )
        end
      
      end
    end
  end
end