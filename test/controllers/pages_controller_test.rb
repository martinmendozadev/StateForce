require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get root_url
    assert_response :success
  end

 test "should get learn more" do
    get learn_more_path
    assert_response :success
  end

  test "should have login button" do
    get root_url
    assert_select "a[href='#{new_user_session_path}']", text: /#{I18n.t("landing.nav.login")}/
  end

  test "should have login button learn more" do
    get learn_more_path
    assert_select "a[href='#{new_user_session_path}']", text: /#{I18n.t("landing.nav.login")}/
  end

  test "should have signup button" do
    get root_url
    assert_select "a[href='#{new_user_registration_path}']", text: /#{I18n.t("landing.hero.cta.primary")}/
  end

  test "should have title learn more" do
    get learn_more_path
    assert_select "h1", text: /#{I18n.t("learn_more.title")}/
  end

  test "should have title" do
    get root_url
    assert_select "h1", text: /#{I18n.t("landing.hero.title")}/
  end

  test "should have subtitle" do
    get root_url
    assert_select "p", text: /#{I18n.t("landing.hero.subtitle")}/
  end

  test "should have learn more button" do
    get root_url
    assert_select "a[href='#{learn_more_path}']", text: /#{I18n.t("landing.nav.learn_more")}/
  end
end
