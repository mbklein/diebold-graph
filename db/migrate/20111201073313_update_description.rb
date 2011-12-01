class UpdateDescription < ActiveRecord::Migration
  def up
    change_column(:presentations, :description, :text)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
