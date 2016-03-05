require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @admin = User.create(username: 'Anthony', email: 'kersuzan.a@example.com', password: 'password', admin: true)
  end

  test 'get new category form and create category' do
    sign_in_as(@admin, 'password')
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do # After performing action, test database record should change by 1
      post_via_redirect categories_path, category: {name: 'sports'}
    end
    assert_template 'categories/index' # After posting, controller should redirect to categories index
    assert_match 'sports', response.body # 'sports' must be visible on the categories index page
  end

  test 'invalid category submission result in failure' do
    sign_in_as(@admin, 'password')
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count', 1 do # After performing action, test database record should not change
      post categories_path, category: {name: ' '}
    end
    assert_template 'categories/new' # After posting, controller should present the form
    assert_select 'h2.panel-title' # header of error messages
    assert_select 'div.panel-body' # body of error messages
  end

end