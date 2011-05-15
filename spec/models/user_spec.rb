require 'pp'
require 'spec_helper'


describe 'User' do
  before :each do
    @attr = {:email => "patrick@rails.com",
             :password => "password11",
             :password_confirmation => "password11",
             :firstname => "Foo",
             :surname => "Bar",
             :category => 'admin',
             :locked => false}
  end
  
  describe 'Successfully creating a user' do
    
    it 'should successfully create an admin user' do
      pp @user = User.create!(@attr)
      @user.should be_valid
    end
    
    it 'should successfully create a basic user' do
      @user = User.new(@attr.merge(:category => 'basic'))
      @user.should be_valid
    end
  end
  
  
  describe 'Error cases - blank fields' do
    
    it "should validate email - cannot be blank" do
      @user = User.new(@attr.merge(:email => nil))
      @user.should_not be_valid

    end
    
    it "should validate surname - cannot be blank" do
      @user = User.new(@attr.merge(:password => nil))
      @user.should_not be_valid
    end
    
    it "should validate  firstname - cannot be blank" do
      @user = User.new(@attr.merge(:firstname => nil))
      @user.should_not be_valid
    end
    
    it "should validate surname - cannot be blank" do
      @user = User.new(@attr.merge(:surname => nil))
      @user.should_not be_valid
    end
    
    it "should validate password - cannot be blank" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end
    
    it "should set the encrypted password" do
      @user = User.create!(@attr)
      @user.encrypted_password.should_not be_blank
    end
    
    it "should validate category - cannot be blank" do
      @user = User.new(@attr.merge(:category => nil))
      @user.should_not be_valid
    end
    
    it 'should validate that all new users are not locked' do
      pp @user = User.create!(@attr)
      @user[:locked].should == false
    end

  end
  
  describe 'Error cases - invalid data' do
    before :each do
      @attr_1 = {:email => "patrick@rails.com",
               :password => "password11",
               :password_confirmation => "password11",
               :firstname => "Foo",
               :surname => "Bar",
               :category => 'admin',
               :locked => false}    
    end
    
    ['patrick@@rails.com', 'patrick@rails', 'patrick@333.m34@', '@name.com'].each do |email|
      it "should only allow valid email addresses e.g.#{email}" do
        @user = User.new(@attr.merge(:email => email))
        @user.should_not be_valid
      end
    end
    
    it 'should not allow first name to exceed 30 characters' do
      @user = User.new(@attr.merge(:firstname => 'a'*31))
      @user.should_not be_valid
    end
    
    it 'should not allow surname to exceed 30 characters' do
      @user = User.new(@attr.merge(:surname => 'a'*31))
      @user.should_not be_valid
    end
    
    it 'should only allow the attributes admin and basic as the types' do
      ['super', 'user', 'category', '1', 0, 'true'].each do |category|
        @user = User.new(@attr.merge(:category => category))
        @user.should_not be_valid
      end
    end
    
    it 'should allow duplicate emails in to the system' do
      @user = User.create!(@attr)
      @user.should be_valid
      
      @user_1 = User.new(@attr)
      @user_1.should_not be_valid
    end
    
    it "should not allow duplicate emails of upper case" do
      @user = User.create!(@attr)
      @user.should be_valid
      
      @user_1 = User.new(@attr[:email].upcase)
      @user_1.should_not be_valid
    end
    
    it "should validate that the confirmation password and password match" do
      @user = User.new(@attr.merge(:passowrd => "password11", :password_confirmation => 'password12'))
      @user.should_not be_valid
    end    
    
    it "should only allow a password of minimum length of 8 characters" do
      @user = User.create(@attr.merge(:password => 'paswo11'))
      @user.should_not be_valid  
    end
    
    it "passwords should contain at least 2 numberic values" do
      @user = User.create(@attr.merge(:password => 'password', :password_confirmation => 'password'))
      @user.should_not be_valid
    end
    
    it 'should reject long passwords' do
      @user = User.create(@attr.merge(:password => 'a'*44, :password_confirmation => 'a'*44))
      @user.should_not be_valid
    end
    
    it 'should have an encrypted password attribute' do
      @user = User.new
      @user.respond_to?(:encrypted_password).should == true
    end
    
    it 'should have a locked attribute' do
      @user = User.new
      @user.should respond_to(:locked)
    end    
  end
  
  describe 'Password Encryption' do
    before(:each) do
         @user = User.create!(@attr)
       end
       
    describe 'has_password method' do
      it 'should be true if passwords match each other' do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it 'should be false if passwords do not match each other' do
        @user.has_password?("invalid").should be_false
      end
    end
  end
  
  
end







