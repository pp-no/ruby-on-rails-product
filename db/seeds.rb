User.find_or_initialize_by(email: "demo@example.com").tap do |user|
  user.name = "Demo User"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.save!
end

products = [
  {
    name: "オーバーサイズ ロゴTシャツ",
    brand_name: "North Street",
    price: 3900,
    description: "ドロップショルダーの定番ロゴT。",
    category: "メンズ",
    size_info: "M/L/XL",
    image_url: "https://images.pexels.com/photos/2404844/pexels-photo-2404844.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "ワイドテーパード チノパン",
    brand_name: "North Street",
    price: 7900,
    description: "腰回りゆったり、裾すっきりの一本。",
    category: "メンズ",
    size_info: "S/M/L",
    image_url: "https://images.pexels.com/photos/35568704/pexels-photo-35568704.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "撥水マウンテンジャケット",
    brand_name: "Trail Works",
    price: 12800,
    description: "軽量で街使いしやすい撥水シェル。",
    category: "メンズ",
    size_info: "M/L",
    image_url: "https://images.pexels.com/photos/23363491/pexels-photo-23363491.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "クルーネックスウェット",
    brand_name: "Daily Loom",
    price: 6200,
    description: "裏毛素材でロングシーズン着用可能。",
    category: "メンズ",
    size_info: "M/L/XL",
    image_url: "https://images.pexels.com/photos/16532060/pexels-photo-16532060.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "レギュラーフィット デニム",
    brand_name: "Blue Harbor",
    price: 9800,
    description: "ベーシックなストレートシルエット。",
    category: "メンズ",
    size_info: "29/31/33",
    image_url: "https://images.pexels.com/photos/13137728/pexels-photo-13137728.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "コットンリネン シャツ",
    brand_name: "Blue Harbor",
    price: 7100,
    description: "通気性の高いコットンリネン生地。",
    category: "メンズ",
    size_info: "M/L",
    image_url: "https://images.pexels.com/photos/2404844/pexels-photo-2404844.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: false
  },
  {
    name: "フレアロングスカート",
    brand_name: "Lumiere",
    price: 8400,
    description: "歩くたびに揺れる軽やかなフレア。",
    category: "レディース",
    size_info: "S/M",
    image_url: "https://images.pexels.com/photos/12453991/pexels-photo-12453991.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "ボウタイブラウス",
    brand_name: "Lumiere",
    price: 6800,
    description: "オンオフ使える上品なボウタイ付き。",
    category: "レディース",
    size_info: "M",
    image_url: "https://images.pexels.com/photos/9430996/pexels-photo-9430996.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "ノーカラーライトコート",
    brand_name: "Sable Mode",
    price: 13900,
    description: "すっきり見えする軽量ライトアウター。",
    category: "レディース",
    size_info: "M/L",
    image_url: "https://images.pexels.com/photos/19192233/pexels-photo-19192233.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "ハイウエスト スラックス",
    brand_name: "Sable Mode",
    price: 9200,
    description: "脚長見えを狙えるハイウエスト設計。",
    category: "レディース",
    size_info: "S/M/L",
    image_url: "https://images.pexels.com/photos/6903025/pexels-photo-6903025.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "リブニット カーディガン",
    brand_name: "Mellow Days",
    price: 5900,
    description: "羽織りにもトップスにも使える2WAY。",
    category: "レディース",
    size_info: "F",
    image_url: "https://images.pexels.com/photos/8945243/pexels-photo-8945243.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  },
  {
    name: "ミニショルダーバッグ",
    brand_name: "Mellow Days",
    price: 4500,
    description: "必要最低限が収まる軽量ミニバッグ。",
    category: "レディース",
    size_info: "W20xH14xD7cm",
    image_url: "https://images.pexels.com/photos/14837855/pexels-photo-14837855.jpeg?auto=compress&cs=tinysrgb&w=1200",
    published: true
  }
]

products.each do |attrs|
  Product.find_or_initialize_by(name: attrs[:name], brand_name: attrs[:brand_name]).tap do |product|
    product.assign_attributes(attrs)
    product.save!
  end
end
