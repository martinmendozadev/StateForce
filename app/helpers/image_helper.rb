# app/helpers/image_helper.rb

module ImageHelper
  def cdn_image(key_or_url, **options)
    url = resolve_cdn_url(key_or_url)
    return unless url.present?

    opts = normalize_cdn_image_options(options)
    image_tag(url, **opts)
  end

  # Inline an SVG icon from app/assets/images/icons so it can be styled with Tailwind.
  # Usage:
  #   <%= svg_icon :arrow_right, class: 'size-5 text-gray-500' %>
  #   <%= svg_icon 'arrow-right', class: 'h-5 w-5', title: 'Abrir' %>
  # Notas:
  # - Inlining permite fill="currentColor" para heredar color con Tailwind (text-*)
  # - Si no se encuentra el archivo, cae a CDN usando :<nombre>_icon (renderiza <img>)
  def svg_icon(name, title: nil, aria_hidden: true, **attrs)
    path = icon_path_for(name)
    return cdn_fallback_for(name, title: title, attrs: attrs) if path.nil?

    content = inline_svg_content(path)
    content = strip_root_class(content)
    content = ensure_fill_current_color(content)

    attrs_pairs = build_svg_attrs_pairs(attrs: attrs, title: title, aria_hidden: aria_hidden)
    content = inject_attrs_into_svg_tag(content, attrs_pairs) if attrs_pairs.any?

    content = inject_title(content, title) if title.present?
    content.html_safe
  end

  private

  def resolve_cdn_url(key_or_url)
    return nil if key_or_url.nil?

    if key_or_url.is_a?(String)
      str = key_or_url.strip
      return nil if str.empty?
      return str if str.match?(/\Ahttps?:\/\//)
      key = str.tr("-", "_").to_sym
    else
      # Safely coerce to symbol if possible
      key = key_or_url.respond_to?(:to_sym) ? key_or_url.to_sym : nil
    end

    return nil if key.nil?
    defined?(CDN_IMAGES) ? CDN_IMAGES[key] : nil
  end

  def normalize_cdn_image_options(options)
    # Normalize keys to symbols and correct common typos
    opts = options.transform_keys { |k| k.to_s.underscore.to_sym }
    # Fix typo: :atl -> :alt (only if :alt not already provided)
    if opts.key?(:atl) && !opts.key?(:alt)
      opts[:alt] = opts.delete(:atl)
    end
    opts
  end

  def icons_dir
    @icons_dir ||= Rails.root.join("app/assets/images/icons")
  end

  def normalized_name(name)
    name.to_s.delete_suffix(".svg")
  end

  def icon_candidates(name)
    base = normalized_name(name)
    [ base, base.tr("_", "-") ]
  end

  def icon_path_for(name)
    icon_candidates(name)
      .map { |n| icons_dir.join("#{n}.svg") }
      .find { |p| File.exist?(p) }
  end

  # Simple file read cache that busts on mtime changes
  def inline_svg_content(path)
    mtime = File.mtime(path).to_i rescue 0
    key = [ "svg", path.to_s, mtime ].join(":")
    if defined?(Rails) && Rails.respond_to?(:cache) && Rails.cache
      Rails.cache.fetch(key) { File.read(path) }
    else
      File.read(path)
    end
  end

  def strip_root_class(content)
    content.sub(/<svg\b([^>]*?)\sclass="[^"]*"/i, '<svg\\1')
  end

  def ensure_fill_current_color(content)
    content.sub(/<svg\b(?![^>]*\sfill=")/i, '<svg fill="currentColor" ')
  end

  def build_svg_attrs_pairs(attrs:, title:, aria_hidden:)
    pairs = []
    css_class = attrs.delete(:class)
    pairs << %(class="#{ERB::Util.html_escape(css_class)}") if css_class.present?
    if title.present?
      pairs << %(role="img")
    else
      pairs << %(aria-hidden="true") if aria_hidden
    end
    attrs.each { |k, v| pairs << %(#{k.to_s.dasherize}="#{ERB::Util.html_escape(v)}") }
    pairs
  end

  def inject_attrs_into_svg_tag(content, attrs_pairs)
    content.sub(/<svg\b/i, "<svg #{attrs_pairs.join(' ')}")
  end

  def inject_title(content, title)
    title_tag = "<title>#{ERB::Util.html_escape(title)}</title>"
    with_title = content.sub(/<svg[^>]*>/i) { |m| m + title_tag }
    # Asegura accesibilidad si se inyectó aria-hidden antes del title
    with_title.sub(/\saria-hidden="true"/i, "")
  end

  def cdn_fallback_for(name, title:, attrs: {})
    key = "#{normalized_name(name)}_icon".tr("-", "_").to_sym
    return cdn_image(key, alt: title, **attrs) if defined?(CDN_IMAGES) && CDN_IMAGES.key?(key)
    nil
  end
end
