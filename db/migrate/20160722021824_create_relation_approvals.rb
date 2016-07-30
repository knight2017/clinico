class CreateRelationApprovals < ActiveRecord::Migration
  def change
    create_table :relation_approvals do |t|
      t.boolean :approved
      t.references :user, index: true, foreign_key: true
      t.references :doctor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
