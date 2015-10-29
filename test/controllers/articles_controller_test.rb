require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "login is required to update" do
    user    = create_user("su")
    article = Article.create!(
      body:  "This is the old text",
      title: "Title",
      owner: create_user("tom")
    )

    patch :update, id: article.id, article: { body: "Updated" }
    assert_equal 302, response.status
    article.reload
    assert_equal "This is the old text", article.body

    sign_in user
    patch :update, id: article.id, article: { body: "Updated" }
    article.reload
    assert_equal "Updated", article.body

    # Doesn't raise an error ...
    # Something about `response` ...
  end
end
