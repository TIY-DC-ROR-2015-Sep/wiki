class Edit < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates_presence_of :article, :user, :new_version
end
