require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "can undo edits" do
    article = Article.create!(
      body:  "This is the old text",
      title: "Title",
      owner: create_user("tom")
    )

    katie = create_user "katie"
    katie.edit article, "This is a good revision"
    katie.edit article, "This is a bad revision"

    e = article.edits.last
    assert_equal "This is a bad revision", e.new_version
    assert_equal 2, article.edits.count

    article.undo e

    assert_equal "This is a good revision", article.body
    assert_equal 3, article.edits.count
    assert article.edits.last.revert?
  end
end
