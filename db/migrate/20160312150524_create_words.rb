class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.text :name, index: true
      t.text :parent, array: true, default: []
      t.text :child, array: true, default: []
      t.float :feel, default: 0.50
      t.text :traits, array: true, default: []
      t.text :look, array: true, default: []
      t.text :shape, array: true, default: []
      t.text :color, array: true, default: []
      t.text :sound, array: true, default: []
      t.text :touchs, array: true, default: []
      t.text :temperature, array: true, default: []
      t.text :taste, array: true, default: []
      t.text :syno, array: true, default: []
      t.text :unsyno, array: true, default: []
      t.text :before, array: true, default: []
      t.text :after, array: true, default: []
      t.text :personality, array: true, default: []
      t.text :tool, array: true, default: []
      t.text :onething, array: true, default: []
      t.text :parts, array: true, default: []

      t.timestamps null: false
    end
  end
end
