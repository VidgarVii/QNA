class CreateHonorsAndUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :honors_users, id: false do |t|
      t.belongs_to :honor, index: true
      t.belongs_to :user, index: true
    end
  end
end
