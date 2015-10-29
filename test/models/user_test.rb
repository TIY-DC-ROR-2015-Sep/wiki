require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # def test_that_passes
  #   assert_equal (2+2), 4
  # end
  #
  # def test_that_fails
  #   assert_equal 3, 4
  # end

  test "users can edit articles" do
    user    = create_user("su")
    article = Article.create!(
      body:  "This is the old text",
      title: "Title",
      owner: create_user("tom")
    )

    user.edit article, "This is the new text"

    assert_equal "This is the new text", article.body
    assert_equal 1, user.edits.count

    e = article.edits.last
    assert_equal "This is the old text", e.old_version
    assert_equal "This is the new text", e.new_version
    assert_equal user, e.user
  end
end
