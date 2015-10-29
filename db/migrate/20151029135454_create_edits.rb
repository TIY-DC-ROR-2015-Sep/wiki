class CreateEdits < ActiveRecord::Migration
  def change
    create_table :edits do |t|
      t.belongs_to :article, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.text :old_version
      t.text :new_version

      t.timestamps null: false
    end
  end
end
