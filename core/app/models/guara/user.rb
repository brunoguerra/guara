# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(25)
#  email      :string(100)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

module Guara
  
  class User < ActiveRecord::Base
    include ActiveExtend::ActiveDisablable
  
    #attr_readonly :admin
    attr_accessible :name, :email, :password, :password_confirmation, :admin, :remember_me, :users_has_groups, 
                    :primary_group, :secundary_groups, :primary_company_business, :primary_company_business_id,
                    :type_id
  
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, and :omniauthable, :registerable
    devise :database_authenticatable,
           :recoverable, :rememberable, :trackable, :validatable, :timeoutable

    #RELATIONSHIPS<===================================================================
    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token
  
    has_many :microposts, dependent: :destroy
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
  
    has_many :reverse_relationships, foreign_key: "followed_id",
                                       class_name:  "Relationship",
                                       dependent:   :destroy
    has_many :followers, through: :reverse_relationships, source: :follower
  
    has_many :abilities, class_name: "UserAbility", :as => :skilled
  
    has_many :tasks
  
    has_many :assigned_tasks, class_name: "Task", foreign_key: "assigned_id"
  
    belongs_to :primary_company_business, class_name: "CompanyBusiness"
  
    #GROUPS<=================
    belongs_to :primary_group, class_name: "UserGroup", foreign_key: "primary_group_id"
    has_many :users_has_groups, class_name: "UsersHasGroups"
    has_many :secundary_groups, through: :users_has_groups, source: :user_group
  
    #VALIDATIONS<============================================================
    #BASICS
    VALID_NAME_REGEX = /\A\w+.*\s.*\z/i
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
    validates :name,  presence: true, length: { maximum: 30 }, uniqueness: true #, format: { with: VALID_NAME_REGEX }
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } #:email => true
  
    #PASSWORD  
    validates :password, presence: true, length: { minimum: 6 }, :if => :need_password?
    validates :password_confirmation, presence: true, :if => :need_password?
  
    public
  
      def feed
        # This is preliminary. See "Following users" for the full implementation.
        Micropost.where("user_id = ?", id)
      end
    
      def following?(other_user)
        relationships.find_by_followed_id(other_user.id)
      end

      def follow!(other_user)
        relationships.create!(followed_id: other_user.id)
      end
    
      def unfollow!(other_user)
        relationships.find_by_followed_id(other_user.id).destroy
      end
    
      def groups
        ret = []
        ret << self.primary_group if (self.primary_group)
        ret << self.secundary_groups if (self.secundary_groups)
        ret.flatten.uniq
      end
    
      def all_abilities
        abilities = []
        abilities << self.abilities  if (self.abilities)
        abilities << self.groups.collect { |g| g.abilities } if (self.groups)
        abilities.flatten.flatten.uniq
      end
    
      def able?(module_, ability)
        all_abilities.select { |ab| ab.module.id == module_.id && ab.ability.id == ability.id }.count > 0 
      end
    
      def define_abilities(modules_and_abilities)
        self.abilities.each do |u_ability|
          u_ability.delete
        end
        labilities = []
      
        modules_and_abilities.each do |module_and_ability|
          labilities << abilities.build(module_and_ability)
        end
      
        self.abilities = labilities
      
      end
  
    private

      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end
    
      def need_password?
        return self.new_record? || (password.to_s.strip.length != 0) || (password_confirmation.to_s.strip.length != 0)
      end
  
  
  end
  
end