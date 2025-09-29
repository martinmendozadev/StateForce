# frozen_string_literal: true

require "test_helper"

class ImageHelperTest < ActionView::TestCase
  include ImageHelper

  setup do
    @icons_dir = Rails.root.join("app/assets/images/icons")
    FileUtils.mkdir_p(@icons_dir)
  end

  teardown do
    # Clean up any test svg we created
    test_svg = @icons_dir.join("test_icon.svg")
    File.delete(test_svg) if File.exist?(test_svg)
  end

  test "cdn_image returns image tag for symbol key" do
    html = cdn_image(:logo_white, alt: "Logo")
    assert_includes html, "img"
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
  end

  test "cdn_image normalizes atl typo to alt" do
    url = "https://example.com/typo.png"
    html = cdn_image(url, atl: "Typo")
    assert_includes html, "alt=\"Typo\""
  end

  test "svg_icon inlines svg and injects fill and class" do
    svg_source = <<~SVG
      <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M0 0h24v24H0z" fill="none"/></svg>
    SVG
    File.write(@icons_dir.join("test_icon.svg"), svg_source)

    html = svg_icon(:test_icon, class: "h-5 w-5 text-primary")
    assert_includes html, "<svg"
    assert_includes html, "fill=\"currentColor\""
    assert_includes html, "class=\"h-5 w-5 text-primary\""
  end

  test "svg_icon adds title and role img when title present" do
    svg_source = <<~SVG
      <svg viewBox="0 0 10 10" xmlns="http://www.w3.org/2000/svg"></svg>
    SVG
    File.write(@icons_dir.join("test_icon.svg"), svg_source)

    html = svg_icon(:test_icon, title: "Prueba", class: "x")
    assert_includes html, "<title>Prueba</title>"
    assert_includes html, "role=\"img\""
    refute_includes html, "aria-hidden"
  end

  test "svg_icon falls back to cdn image when file missing and key exists" do
    # Use :google (expects google_icon in CDN) and ensure no local file exists
    File.delete(@icons_dir.join("google.svg")) if File.exist?(@icons_dir.join("google.svg"))

    html = svg_icon(:google, title: "Google")
    assert_includes html, CDN_IMAGES[:google_icon], "Should use CDN fallback"
    assert_includes html, "alt=\"Google\""
  end

  test "svg_icon returns nil when file missing and no cdn fallback" do
    html = svg_icon(:__not_existing_anywhere__, title: "Nada")
    assert_nil html
  end
end
