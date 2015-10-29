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

  test "can't undo edits for the wrong article" do
    tom = create_user("tom")
    article = Article.create!(
      body:  "This is the old text",
      title: "Title",
      owner: tom
    )
    tom.edit article, "Some stuff"

    other = Article.create!(
      body:  "This is another article",
      title: "Title 2",
      owner: tom
    )
    tom.edit other, "Some other stuff"

    wrong_edit = other.edits.last

    assert_raises do
      article.undo wrong_edit
    end
    assert_equal "Some stuff", article.body
    assert_equal 2, Edit.count
  end
end
