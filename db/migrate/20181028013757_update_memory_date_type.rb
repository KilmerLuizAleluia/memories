class UpdateMemoryDateType < ActiveRecord::Migration[5.2]
  def change
    change_column :memories, :date, :date
  end
end
