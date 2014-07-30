class Pipeline < ActiveRecord::Base
  has_many :stages
  has_many :pipeline_users
  has_many :users, :through => :pipeline_users

<<<<<<< HEAD
<<<<<<< HEAD
=======



>>>>>>> 3134d99... Created Models and migrations, integrating with contacts
=======
  validates :name, uniqueness: true
>>>>>>> 890a446... wrote tests and tsx for crreate pipeline, bug in
end
