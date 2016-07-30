class AddAasmStateToApprovals < ActiveRecord::Migration
  def change
    add_column :approvals, :aasm_state, :string
  end
end
