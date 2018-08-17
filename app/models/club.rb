class Club < ActiveRecord::Base
  belongs_to :user

  def self.banned_roles
    return ["droid", "gangster"]
  end
end
