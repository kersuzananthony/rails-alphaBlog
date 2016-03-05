require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest

  def setup

  end

  test 'should sign up' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: 'Anthony', email: 'kersuzan.a@example.com', password: 'password'}
    end
    assert_template 'users/show'
  end

end