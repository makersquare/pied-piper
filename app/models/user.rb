class User < ActiveRecord::Base
  has_many :pipeline_users
  has_many :pipelines, :through => :pipeline_users
<<<<<<< HEAD
end
=======
end
>>>>>>> 3134d99... Created Models and migrations, integrating with contacts
