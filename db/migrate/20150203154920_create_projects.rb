class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :issues_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
