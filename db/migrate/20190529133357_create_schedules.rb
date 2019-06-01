class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :title
      t.datetime :start
      t.datetime :end
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
