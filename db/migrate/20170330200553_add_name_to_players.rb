class AddNameToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :full_name, :string
  end
end
