require "test_helper"

class PdfReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get pdf_reports_generate_url
    assert_response :success
  end
end
