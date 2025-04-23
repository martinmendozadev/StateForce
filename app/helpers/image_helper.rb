# app/helpers/image_helper.rb

module ImageHelper
  def cdn_image(key, **options)
    url = CDN_IMAGES[key]
    return unless url.present?

    image_tag(url, **options)
  end
end
