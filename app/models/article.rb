class Article < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  has_many :edits

  validates_presence_of :title, :owner
end
