require 'test_helper'

module Dobson
  
  class RetinaTest < ActiveSupport::TestCase
    include ::Dobson::RetinaHelper
  
    test "packages" do
      assert_kind_of Module, Dobson
      assert_kind_of Module, Dobson::RetinaHelper
    end
  
    test "test basic helper" do
      
       assert_equal "", retina_img("logo.png")
    end
  
  end
end