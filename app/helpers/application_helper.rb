module ApplicationHelper
  PRODUCT_FALLBACK_IMAGES = {
    "オーバーサイズ ロゴTシャツ" => "https://images.pexels.com/photos/2404844/pexels-photo-2404844.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "ワイドテーパード チノパン" => "https://images.pexels.com/photos/35568704/pexels-photo-35568704.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "撥水マウンテンジャケット" => "https://images.pexels.com/photos/23363491/pexels-photo-23363491.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "クルーネックスウェット" => "https://images.pexels.com/photos/16532060/pexels-photo-16532060.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "レギュラーフィット デニム" => "https://images.pexels.com/photos/13137728/pexels-photo-13137728.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "コットンリネン シャツ" => "https://images.pexels.com/photos/2404844/pexels-photo-2404844.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "フレアロングスカート" => "https://images.pexels.com/photos/12453991/pexels-photo-12453991.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "ボウタイブラウス" => "https://images.pexels.com/photos/9430996/pexels-photo-9430996.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "ノーカラーライトコート" => "https://images.pexels.com/photos/19192233/pexels-photo-19192233.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "ハイウエスト スラックス" => "https://images.pexels.com/photos/6903025/pexels-photo-6903025.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "リブニット カーディガン" => "https://images.pexels.com/photos/8945243/pexels-photo-8945243.jpeg?auto=compress&cs=tinysrgb&w=1200",
    "ミニショルダーバッグ" => "https://images.pexels.com/photos/14837855/pexels-photo-14837855.jpeg?auto=compress&cs=tinysrgb&w=1200"
  }.freeze

  def product_image_source(product)
    image_url = product.image_url.to_s

    return image_url if image_url.present? && !image_url.include?("example.com")

    fallback_image = PRODUCT_FALLBACK_IMAGES[product.name]
    return fallback_image if fallback_image.present?

    svg = <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 800" role="img" aria-label="#{ERB::Util.html_escape(product.name)}">
        <defs>
          <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" stop-color="#f6e5d1" />
            <stop offset="100%" stop-color="#d7b796" />
          </linearGradient>
        </defs>
        <rect width="640" height="800" fill="url(#bg)" />
        <circle cx="510" cy="160" r="120" fill="#f8f1e6" opacity="0.7" />
        <circle cx="140" cy="670" r="150" fill="#c98a5b" opacity="0.15" />
        <rect x="120" y="140" width="400" height="520" rx="200" fill="#fff8ef" opacity="0.95" />
        <rect x="170" y="220" width="300" height="300" rx="150" fill="#d9b190" opacity="0.55" />
        <text x="60" y="94" fill="#7f3217" font-family="Arial, sans-serif" font-size="30" font-weight="700" letter-spacing="6">MINI EC</text>
        <text x="60" y="620" fill="#7f3217" font-family="Arial, sans-serif" font-size="28" font-weight="700">#{ERB::Util.html_escape(product.brand_name)}</text>
        <text x="60" y="664" fill="#3d2d20" font-family="Arial, sans-serif" font-size="40" font-weight="700">#{ERB::Util.html_escape(product.name.tr("&", "＆"))}</text>
        <text x="60" y="716" fill="#6f6255" font-family="Arial, sans-serif" font-size="24">#{ERB::Util.html_escape(product.category.presence || "Curated Item")} / #{ERB::Util.html_escape(product.size_info.presence || "Free Size")}</text>
      </svg>
    SVG

    "data:image/svg+xml,#{ERB::Util.url_encode(svg)}"
  end
end
