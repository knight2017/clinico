class AddAasmStatesToAvailabilities < ActiveRecord::Migration
  def change
    add_column :availabilities, :aasm_state, :string
  end
end
