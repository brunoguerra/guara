include ApplicationHelper
include Guara::AbilityHelper
#def full_title(page_title)
#  base_title = "Ruby on Rails Tutorial Sample App"
#  if page_title.empty?
#    base_title
#  else
#    "#{base_title} | #{page_title}"
#  end
#end

def sign_in(user)
  visit guara.new_user_session_path
  fill_in I18n.t("session.email"),    with: user.email
  fill_in I18n.t("session.password"), with: user.password
  click_button I18n.t("sign.in.link")
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end

def sign_out()
  #click_link I18n.t("sign.out.link")
  visit "/users/sing_out"
end


### Botões automáticos
def autotitle(model_, operation)
  "%s %s" % [I18n.t('helpers.forms.%s' % operation.to_s.downcase), I18n.t('activerecord.models.%s' % model_.to_s.downcase)]
end

def clear_test_dummy
  Guara::User.unscoped.where('email like ?', 'person%').each { |u| u.destroy_fully }
end

def visible?(element)
  find(element).visible?
end

def wait_until_visible(element)
  wait_until { page.find(element).visible? }
end

def wait_until_content(element, content)
  wait_until { have_css(element, content).maches? }
end

def wait_for_response
  wait_until { page.evaluate_script('jQuery.active') == 0 }
  sleep(0.1)
end

#TODO: work any context
def wait_for_animations()
  wait_until { page.evaluate_script('$(":animated").length') == 0 }
end


































### @depracated
# TODO: refactor specs that used
def able_read(user, module_)
  user.abilities.build(:module => module_, :ability => SystemAbility.READ).save
end

def able_update(user, module_)
  user.abilities.build(:module => module_, :ability => SystemAbility.READ).save
  user.abilities.build(:module => module_, :ability => SystemAbility.UPDATE).save
end

def able_create(user, module_)
  user.abilities.build(:module => module_, :ability => SystemAbility.READ).save
  user.abilities.build(:module => module_, :ability => SystemAbility.CREATE).save
end

def able_read_to(user, module_to)
  able_read(user, SystemModule.find_by_name(module_to.titleize))
end

def autotitle_update(model_)
  "%s %s" % [I18n.t('helpers.forms.update'), I18n.t('activerecord.models.%s' % model_.to_s.downcase)]
end
def autotitle_create(model_)
  "%s %s" % [I18n.t('helpers.forms.create'), I18n.t('activerecord.models.%s' % model_.to_s.downcase)]
end

def autotitle_new(model_)
  "%s %s" % [I18n.t('helpers.forms.new'), I18n.t('activerecord.models.%s' % model_.to_s.downcase)]
end
