require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "render 200" do
    post :buscar, tag: 'santiago', access_token: '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402'
    assert_response :success
  end

  test "render 404" do
    post :buscar
    assert_response 400
  end

  test "posts ok" do
    assert_not_equal false, @controller.send(:get_posts, 'santiago', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
  end

  test "total ok" do
    assert_not_equal false, @controller.send(:get_total, 'santiago', '2019746130.59a3f2b.86a0135240404ed5b908a14c0a2d9402')
  end

end
