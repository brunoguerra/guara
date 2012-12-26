module Guara
  module UsersHelper
  
    # Returns the Gravatar (http://gravatar.com/) for the given user.
    def gravatar_for(user, options = { size: 50 })
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
  
    def firstname(user)
      user.name.split[0]
    end
  
    def current_user?(user)
      current_user!=nil && current_user.email == user.email
    end
  
    def task_types_for_current_user
      business = current_user.primary_company_business
      return [] if business.nil? and not current_user.admin?
    
      if not business.nil?
        TaskType.for_business(business)
      else
        TaskType.send :relation
      end
    end
  end
end