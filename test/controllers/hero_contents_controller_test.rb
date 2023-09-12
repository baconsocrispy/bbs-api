require "test_helper"

class HeroContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hero_content = hero_contents(:one)
  end

  test "should get index" do
    get hero_contents_url, as: :json
    assert_response :success
  end

  test "should create hero_content" do
    assert_difference("HeroContent.count") do
      post hero_contents_url, params: { hero_content: { button_text: @hero_content.button_text, header_text: @hero_content.header_text, href: @hero_content.href } }, as: :json
    end

    assert_response :created
  end

  test "should show hero_content" do
    get hero_content_url(@hero_content), as: :json
    assert_response :success
  end

  test "should update hero_content" do
    patch hero_content_url(@hero_content), params: { hero_content: { button_text: @hero_content.button_text, header_text: @hero_content.header_text, href: @hero_content.href } }, as: :json
    assert_response :success
  end

  test "should destroy hero_content" do
    assert_difference("HeroContent.count", -1) do
      delete hero_content_url(@hero_content), as: :json
    end

    assert_response :no_content
  end
end
