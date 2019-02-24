class CreateHonors < ActiveRecord::Migration[5.2]
  def change
    create_table :honors do |t|
      t.string :name, null: false
      t.references :question, foreigh_key: true
      t.references :user, foreigh_key: true, null: true

      t.timestamps
    end
  end
end
