# Seed file, feel free to add or edit to it, it clears out your data every time you use
# it, the one thing I couldn't get working was that the Boxes won't create
# The code at the bottom though works if you use it in rails console

require 'pry-byebug'

def clear_tables
  Pipeline.all.each {|p| p.destroy}
  Stage.all.each {|s| s.destroy}
  Contact.all.each {|c| c.destroy}
  Field.all.each {|f| f.destroy}
  User.all.each {|u| u.destroy}
end
clear_tables

pipeline_admissions = Pipeline.create({name: 'Admissions', trashed: false})
pipeline_hiring = Pipeline.create({name: 'Hiring', trashed: false})
pipeline_get_alumni_jobs = Pipeline.create({name: 'Get alumni jobs', trashed: false})

all_pipelines = [pipeline_admissions, pipeline_hiring, pipeline_get_alumni_jobs]

admissions_stage_list = [
  {name: 'First contact', description: 'reach out', pipeline_location: 1},
  {name: 'Interview', description: 'judge them harshly', pipeline_location: 2},
  {name: 'Decision', description: 'let them know', pipeline_location: 3}
]

admissions_stage_list.each { |stage|
  pipeline_admissions.stages.create(stage)
}

hiring_stage_list = [
  {name: 'Review resume', description: 'take about 60 sec on it', pipeline_location: 1},
  {name: 'Phone screen', description: 'Ask fit questions', pipeline_location: 2},
  {name: 'On-site interview', description: 'need to be interviewed by founders', pipeline_location: 3}
]

hiring_stage_list.each { |stage|
  pipeline_hiring.stages.create(stage)
}


jobs_stage_list = [
  {name: 'Applying to companies', description: 'make sure each app is customized', pipeline_location: 1},
  {name: 'Interviewing', description: 'prep these students', pipeline_location: 2},
  {name: 'Reviewing offers', description: 'do 1 on 1 to review offers', pipeline_location: 3}
]

jobs_stage_list.each { |stage|
  pipeline_get_alumni_jobs.stages.create(stage)
}

common_fields_list = [
  {field_name: 'name', field_type: 'string'},
  {field_name: 'email', field_type: 'string'},
  {field_name: 'phoneNum', field_type: 'string'},
  {field_name: 'city', field_type: 'string'}
]

Field.create(common_fields_list)

Array(1..4).each { |field_number|
  PipelineField.create(pipeline_id: 1, field_id: field_number)
  PipelineField.create(pipeline_id: 2, field_id: field_number)
  PipelineField.create(pipeline_id: 3, field_id: field_number)
}

pipeline_get_alumni_jobs.fields.create({field_name: 'top_choice_company', field_type: 'string'})
pipeline_admissions.fields.create({field_name: 'cohort_desired', field_type: 'string'})
pipeline_hiring.fields.create({field_name: 'hiring_position', field_type: 'string'})


contacts_list = [
  {name: 'Andrew', email: 'andrew@gmail.com', phoneNum: '(650) 555-5126', city: 'San Francisco'},
  {name: 'Gideon', email: 'gideon@gmail.com', phoneNum: '(650) 555-5126', city: 'San Francisco'},
  {name: 'Jered', email: 'jered@gmail.com', phoneNum: '(650) 555-5126', city: 'San Francisco'},
  {name: 'Jon', email: 'jon@gmail.com', phoneNum: '(650) 555-5126', city: 'San Francisco'},
  {name: 'Catherine', email: 'catherine@gmail.com', phoneNum: '(650) 555-5126', city: 'Barstow'},
  {name: 'DJ', email: 'dj@gmail.com', phoneNum: '(650) 555-5126', city: 'Barstow'},
  {name: 'Gabe', email: 'gabe@gmail.com', phoneNum: '(650) 555-5126', city: 'Barstow'},
  {name: 'Alex', email: 'alex@gmail.com', phoneNum: '(650) 555-5126', city: 'Barstow'}
]

Contact.create(contacts_list)

#Not sure what to do here as the users table has a lot oath crap in it
internal_users_list = [
  {name: 'Shehzan', email: 'shehzan@gmail.com'},
  {name: 'Shaan', email: 'shaan@gmail.com'},
  {name: 'Nikhil', email: 'nik@gmail.com'},
  {name: 'Amanda', email: 'amanda@gmail.com'}
]

internal_users_list.each { |user|
  user_entity = User.create(user)
  PipelineUser.create(pipeline_id: 1, user_id: user_entity.id, admin: true)
  PipelineUser.create(pipeline_id: 2, user_id: user_entity.id, admin: true)
  PipelineUser.create(pipeline_id: 3, user_id: user_entity.id, admin: true)
}

# Unable to create Boxes inside this seed file you have to run this in rails console if you want example Boxes

# 8.times do |i|
#   Box.create(stage_id: rand(9) + 1, contact_id: rand(8) + 1)
# end
