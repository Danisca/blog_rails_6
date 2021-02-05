require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "danis", email: "danis@mail.com",password: "password",user_role: "admin") 
    login_user_as(@user) 
  end
  
   test "get new category form and create category" do
     get "/categories/new"# or new_categories_path
     assert_response :success
     assert_difference "Category.count", 1 do
       #categories_path
        post "/categories", params: { category: {name: "Sports"}}
        assert_response :redirect
     end
     follow_redirect!
     assert_response :success
     #the last assertion waits that the name of the new created category must be showed at least
     #when is redirected 
     assert_match "Sports", response.body
   end

   test "get new category form and reject invalid category" do
     get "/categories/new"# or new_categories_path
     assert_response :success
     assert_no_difference "Category.count" do
       #categories_path
        post "/categories", params: { category: {name: " "}}
     end
     assert_match "errors", response.body
     assert_select "div.alert"
     assert_select "h3.alert-heading"
   end
end
