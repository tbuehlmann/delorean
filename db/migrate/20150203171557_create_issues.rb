class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, default: 0, null: false
      t.belongs_to :project, null: false, index: true

      t.timestamps null: false
    end
    add_foreign_key :issues, :projects
  end
end
