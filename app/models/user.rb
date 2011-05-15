class User < ActiveRecord::Base
  
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation, :firstname, :surname, :category, :locked
  
    
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  password_reg = /(\d+)/
  
  validates :email, :presence => true,
            :format => {:with => email_regex},
            :uniqueness => {:case_sensitive => true}
  
  validates :password, :presence => true,
            :length => {:within => 8..42},
            :format => password_reg,
            :confirmation        => true
  
  validates :category, :presence =>true,
            :inclusion => { :in => %w(admin basic) }
          
  validates :firstname, :presence => true,
            :length   => { :maximum => 30 }
  
  validates :surname, :presence => true,             
            :length   => { :maximum => 30 }
  
  before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
    
  
  private
  def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def default_values
      self.category = false
    end
end
