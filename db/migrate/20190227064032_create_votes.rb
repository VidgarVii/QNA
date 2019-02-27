class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :state, default: 0, null: false
      t.references :user, foreign_key: true
      t.references :rating, foreign_key: true

      t.timestamps
    end

    add_index :votes, [:user_id, :rating_id], unique: true
  end
end
