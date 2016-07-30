class CreateTaggingSpecializations < ActiveRecord::Migration
  def change
    create_table :tagging_specializations do |t|
      t.references :specialization, index: true, foreign_key: true
      t.references :doctor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
