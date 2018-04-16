class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.integer :level, default: 0
      t.text :message

      t.timestamps
    end
  end
end
