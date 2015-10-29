class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :edits

  def edit article, text
    edits.create!(
      article:     article,
      old_version: article.body,
      new_version: text
    )
    article.update! body: text
  end
end
