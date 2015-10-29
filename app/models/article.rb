class Article < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  has_many :edits

  validates_presence_of :title, :owner

  def undo edit
    edits.create!(
      old_version: body,
      new_version: edit.old_version
    )
    update! body: edit.old_version
  end
end
