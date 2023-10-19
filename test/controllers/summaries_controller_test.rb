require "test_helper"

class SummariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @summary = summaries(:one)
  end

  test "should get index" do
    get summaries_url, as: :json
    assert_response :success
  end

  test "should create summary" do
    assert_difference("Summary.count") do
      post summaries_url, params: { summary: { copy: @summary.copy, header: @summary.header } }, as: :json
    end

    assert_response :created
  end

  test "should show summary" do
    get summary_url(@summary), as: :json
    assert_response :success
  end

  test "should update summary" do
    patch summary_url(@summary), params: { summary: { copy: @summary.copy, header: @summary.header } }, as: :json
    assert_response :success
  end

  test "should destroy summary" do
    assert_difference("Summary.count", -1) do
      delete summary_url(@summary), as: :json
    end

    assert_response :no_content
  end
end
