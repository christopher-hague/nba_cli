class AddScheduleColToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :team_name, :string
  end
end
