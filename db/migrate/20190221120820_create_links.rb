class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.references :linkable, polymorphic: true

      t.timestamps
    end
  end
end
