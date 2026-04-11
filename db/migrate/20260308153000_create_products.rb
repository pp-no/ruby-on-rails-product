class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :brand_name, null: false
      t.integer :price, null: false
      t.text :description
      t.string :category
      t.string :size_info
      t.string :image_url
      t.boolean :published, null: false, default: true

      t.timestamps
    end
  end
end
