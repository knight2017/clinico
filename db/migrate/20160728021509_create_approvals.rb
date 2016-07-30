class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.boolean :approved, default: false
      t.references :user, index: true, foreign_key: true
      t.references :doctor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
