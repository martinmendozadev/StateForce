# frozen_string_literal: true

require "test_helper"

class ImageHelperTest < ActionView::TestCase
  include ImageHelper

  setup do
    @icons_dir = Rails.root.join("app/assets/images/icons")
    FileUtils.mkdir_p(@icons_dir)
    @created = []
  end

  teardown do
    @created.each do |file|
      File.delete(file) if File.exist?(file)
    end
  end

  def write_icon(name, content)
    path = @icons_dir.join("#{name}.svg")
    File.write(path, content)
    @created << path
    path
  end

  test "cdn_image returns image tag for symbol key" do
    html = cdn_image(:logo_white, alt: "Logo")
    assert_includes html, "<img"
    assert_includes html, CDN_IMAGES[:logo_white]
    assert_includes html, "alt=\"Logo\""
  end

  test "cdn_image returns nil for nil key" do
    assert_nil cdn_image(nil)
  end

  test "cdn_image returns nil for unknown key" do
    assert_nil cdn_image(:__missing_key__)
  end

  test "cdn_image accepts direct URL string" do
    url = "https://example.com/x.png"
    html = cdn_image(url, alt: "X")
    assert_includes html, url
    assert_includes html, "alt=\"X\""
  end

  test "cdn_image normalizes atl typo to alt" do
    url = "https://example.com/typo.png"
    html = cdn_image(url, atl: "Typo")
    assert_includes html, "alt=\"Typo\""
  end

  test "svg_icon returns nil when missing locally and no CDN fallback" do
    assert_nil svg_icon(:totally_missing_icon, title: "Nada")
  end

  test "svg_icon uses CDN fallback when local file absent but *_icon key exists" do
    html = svg_icon(:google, title: "Google")
    assert_includes html, CDN_IMAGES[:google_icon]
    assert_includes html, "alt=\"Google\""
  end

  test "svg_icon strips existing class on root svg before injecting new ones" do
    write_icon(:strip_test, '<svg class="old" viewBox="0 0 1 1" xmlns="http://www.w3.org/2000/svg"></svg>')
    html = svg_icon(:strip_test, class: "new-class")
    refute_includes html, 'class="old"'
    assert_includes html, 'class="new-class"'
  end

  test "svg_icon injects fill=currentColor when svg missing fill attribute" do
    write_icon(:fill_test, '<svg viewBox="0 0 1 1" xmlns="http://www.w3.org/2000/svg"></svg>')
    html = svg_icon(:fill_test)
    assert_includes html, 'fill="currentColor"'
  end

  test "svg_icon does not override existing fill attribute" do
    write_icon(:fill_keep, '<svg fill="red" viewBox="0 0 1 1" xmlns="http://www.w3.org/2000/svg"></svg>')
    html = svg_icon(:fill_keep)
    assert_includes html, 'fill="red"'
    refute_match(/fill="currentColor".*fill="red"/, html)
  end

  test "svg_icon with title adds role img and removes aria-hidden" do
    write_icon(:title_test, '<svg viewBox="0 0 1 1" xmlns="http://www.w3.org/2000/svg"></svg>')
    html = svg_icon(:title_test, title: "Titulo")
    assert_includes html, '<title>Titulo</title>'
    assert_includes html, 'role="img"'
    refute_includes html, 'aria-hidden'
  end

  test "svg_icon without title keeps aria-hidden" do
    write_icon(:hidden_test, '<svg viewBox="0 0 1 1" xmlns="http://www.w3.org/2000/svg"></svg>')
    html = svg_icon(:hidden_test)
    assert_includes html, 'aria-hidden="true"'
  end
end
