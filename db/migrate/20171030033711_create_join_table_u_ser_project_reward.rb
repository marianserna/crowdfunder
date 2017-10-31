class CreateJoinTableUSerProjectReward < ActiveRecord::Migration[5.1]
  def change
    create_table :claims do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.belongs_to :reward
      t.timestamps
      t.integer :user_id, null: false
      t.integer :project_id, null: false
      t.integer :reward_id, null: false
    end
  end
end
