class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.belongs_to :owner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
