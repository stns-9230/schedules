class CreateImportants < ActiveRecord::Migration[5.2]
  def change
    create_table :importants do |t|
      t.references :user, foreign_key: true
      t.references :schedule, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :schedule_id], unique: true
    end
  end
end
