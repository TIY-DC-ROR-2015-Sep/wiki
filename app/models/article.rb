class Article < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  has_many :edits

  validates_presence_of :title, :owner
  validates_uniqueness_of :title

  def undo edit
    unless id == edit.article_id
      raise "Trying to undo edit for wrong article (#{edit.article_id})"
    end
    
    edits.create!(
      old_version: body,
      new_version: edit.old_version
    )
    update! body: edit.old_version
  end
end
