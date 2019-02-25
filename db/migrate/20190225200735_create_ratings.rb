class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.references :rateable, polymorphic: true

      t.timestamps
    end
  end
end
