require 'test_helper'
class CategoryTest < ActiveSupport::TestCase
  #this setup method is called each time by the tests
  def setup
    @category = Category.new(name: "Sports")
  end

  test  "should be valid"  do
    assert @category.valid?
  end
  
  test  "name should be present"  do
    @category.name = ""
    #this test should fails because the name is empty
    assert_not @category.valid?
  end

  test  "name should be unique"  do
    @category.save
    #this test check that this new category be different than the last saved
    #that because the @category2.save should return false
    @category2 = Category.new(name:"Sports")
    assert_not @category2.valid?
  end
  
  test  "name should not be too long"  do
    #the maximun length should be 25
    @category.name = "a" * 26 
    assert_not @category.valid?
  end

  test  "name should not be too short"  do
    #the maximun length should be 25
    @category.name = "a"
    assert_not @category.valid?
  end
end
