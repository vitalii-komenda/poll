class User < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_many :votes, :dependent => :destroy

end
