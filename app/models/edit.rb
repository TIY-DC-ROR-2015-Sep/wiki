class Edit < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  # No user means this was a system edit
  validates_presence_of :article, :new_version

  def revert?
    user.nil?
  end
end
