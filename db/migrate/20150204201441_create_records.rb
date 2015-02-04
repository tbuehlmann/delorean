class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :worked, null: false
      t.date :worked_at, null: false
      t.belongs_to :issue, null: false, index: true

      t.timestamps null: false
    end
    add_foreign_key :records, :issues
  end
end
