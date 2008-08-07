require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  should_have_many :stars
  should_have_many :starred_items
  
  should_require_attributes :login, :password, :password_confirmation #, :email
  should_ensure_length_in_range :password, (4..40)
  should_ensure_length_in_range :login, (3..40)
  
  # TODO test that only some fields are accessible
  
  context 'A user' do
    setup do
      @user = Factory(:user, :login => 'login', :password => 'password', :password_confirmation => 'password')
    end
    
    should_require_unique_attributes :login
    should_allow_values_for :login, 'mylogin', 'woooooo123'
    should_not_allow_values_for :login, 'my login'
    
    should_allow_values_for :url, 'http://example.com'
    should_not_allow_values_for :url, 'example.com'
    
    should 'be able to authenticate with correct password' do
      assert_equal @user, User.authenticate('login', 'password')
    end
    
    should 'not be able to authenticate with incorrect password' do
      assert_nil User.authenticate('login', 'notpassword')
    end
    
    context 'updating their password' do
      setup do
        @user.update_attributes(:password => 'new password', :password_confirmation => 'new password')
      end
      
      should 'be able to login with new password' do
        assert_equal @user, User.authenticate('login', 'new password')
      end
    end
    
    context 'updating their login' do
      setup do
        @user.update_attributes(:login => 'newlogin')
      end
      
      should_eventually 'not rehash password' do
        assert_equal @user, User.authenticate('newlogin', 'password')
      end
    end
    
    context 'being remembered for default amount of time' do
      setup do
        @before_time = 52.week.from_now.utc
        @user.remember_me
        @after_time = 52.weeks.from_now.utc
      end
      
      should 'set remember token' do
        assert_not_nil @user.remember_token
      end
      
      should 'set remember token expires at' do
        assert_not_nil @user.remember_token_expires_at
      end
      
      should 'remember for 52 weeks' do
        assert @user.remember_token_expires_at.between?(@before_time, @after_time)
      end
      
      context 'and then being forgotten' do
        setup do
          @user.forget_me
        end
        
        should 'unset remember token' do
          assert_nil @user.remember_token
        end
      end
    end
    
    context 'being remember until 1 week from now' do
      setup do
        @time = 1.week.from_now.utc

        @user.remember_me_until @time
      end
      
      should 'set remember token' do
        assert_not_nil @user.remember_token
      end
      
      should 'set remember token expires at' do
        assert_not_nil @user.remember_token_expires_at
      end
      
      should 'expire in 1 week' do
        assert_equal @time, @user.remember_token_expires_at
      end
    end
    
    context 'being remembered for 1 week' do
      setup do
        @before_time = 1.week.from_now.utc
        @user.remember_me_for 1.week  
        @after_time = 1.weeks.from_now.utc
      end
      
      should 'set remember token' do
        assert_not_nil @user.remember_token
      end
      
      should 'set remember token expires at' do
        assert_not_nil @user.remember_token_expires_at
      end
      
      should 'remember for 1 weeks' do
        assert @user.remember_token_expires_at.between?(@before_time, @after_time)
      end
    end
  end
  
  context 'A non existant user' do
    should 'not be able to authenticate' do
      assert_nil User.authenticate('nonexistentlogin', 'password')
    end
  end
end
