class UpdateDescription < ActiveRecord::Migration
  def up
    change_column(:presentations, :description, :text, :limit => 5000)
  end

  def down
    change_column(:presentations, :description, :string)
  end
end
