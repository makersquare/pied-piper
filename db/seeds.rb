# Seed file, feel free to add or edit to it, it clears out your data every time you use
# it, the one thing I couldn't get working was that the Boxes won't create
# The code at the bottom though works if you use it in rails console

require 'pry-byebug'

def create_pipelines_with_stages_and_fields
  pipeline_admissions = Pipeline.create({name: 'Admissions', trashed: false})
  pipeline_hiring = Pipeline.create({name: 'Hiring', trashed: false})
  pipeline_get_alumni_jobs = Pipeline.create({name: 'Get alumni jobs', trashed: false})

  all_pipelines = [pipeline_admissions, pipeline_hiring, pipeline_get_alumni_jobs]

  jobs_stage_list = [
    {name: 'Applying to companies', description: 'make sure each app is customized', pipeline_location: 1},
    {name: 'Interviewing', description: 'prep these students', pipeline_location: 2},
    {name: 'Reviewing offers', description: 'do 1 on 1 to review offers', pipeline_location: 3}
  ]

  jobs_stage_list.each { |stage|
    pipeline_get_alumni_jobs.stages.create(stage)
  }


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

  pipeline_get_alumni_jobs.fields.create([
    {field_name: 'top_choice_company', field_type: 'string'},
    {field_name: 'number_companies_applied_to', field_type: 'integer'}
  ])
  pipeline_admissions.fields.create([
    {field_name: 'cohort_desired', field_type: 'string'},
    {field_name: 'candidate_quality_grade', field_type: 'float'}
  ])
  pipeline_hiring.fields.create([
    {field_name: 'hiring_position', field_type: 'string'},
    {field_name: 'position_location', field_type: 'string'}
  ])
end

def clear_tables
  Pipeline.all.each {|p| p.destroy}
  Stage.all.each {|s| s.destroy}
  Contact.all.each {|c| c.destroy}
  Field.all.each {|f| f.destroy}
  User.all.each {|u| u.destroy}
end

def create_contacts
  contacts_list = [
    {name: 'Andrew', email: 'andrew@gmail.com', phonenumber: '(650) 555-5126', city: 'San Francisco'},
    {name: 'Gideon', email: 'gideon@gmail.com', phonenumber: '(650) 555-5126', city: 'San Francisco'},
    {name: 'Jered', email: 'jered@gmail.com', phonenumber: '(650) 555-5126', city: 'San Francisco'},
    {name: 'Jon', email: 'jon@gmail.com', phonenumber: '(650) 555-5126', city: 'San Francisco'},
    {name: 'Catherine', email: 'catherine@gmail.com', phonenumber: '(650) 555-5126', city: 'Barstow'},
    {name: 'DJ', email: 'dj@gmail.com', phonenumber: '(650) 555-5126', city: 'Barstow'},
    {name: 'Gabe', email: 'gabe@gmail.com', phonenumber: '(650) 555-5126', city: 'Barstow'},
    {name: 'Alex', email: 'alex@gmail.com', phonenumber: '(650) 555-5126', city: 'Barstow'},
    {name: 'Maddy', email: 'maddy@gmail.com', phonenumber: '(650) 555-5126', city: 'Austin'},
    {name: 'Michael', email: 'michael@gmail.com', phonenumber: '(650) 555-5126', city: 'Austin'},
    {name: 'Charis', email: 'charis@gmail.com', phonenumber: '(650) 555-5126', city: 'Austin'},
    {name: 'Jason', email: 'jason@gmail.com', phonenumber: '(650) 555-5126', city: 'Austin'}
  ]

  Contact.create(contacts_list)
end

def add_contacts_to_pipelines
  stages = Stage.all

  Contact.all.each_with_index do |contact, i|
    stage_position =  i % Stage.count
    stage = stages[stage_position]
    box = Box.create(contact_id: contact.id, stage_id: stage.id, pipeline_id: stage.pipeline_id,
      pipeline_location: stage.pipeline_location)
    stage.pipeline.fields.each do |field|
      BoxField.create(box_id: box.id, field_id: field.id, value: "Value #{i}:#{field.id}")
    end
  end
end

clear_tables
create_pipelines_with_stages_and_fields
create_contacts
add_contacts_to_pipelines

user_email_settings_list = [
  {pipeline_user_id: 2, setting: "Smartdigest"},
  {pipeline_user_id: 2, setting: "Noemails"},
  {pipeline_user_id: 3, setting: "Dailydigest"}
]

user_email_settings_list.each { |setting|
  EmailSetting.create(setting)
}

#Not sure what to do here as the users table has a lot oath crap in it
internal_users_list = [
  {name: 'Shehzan', email: 'shehzan@gmail.com'},
  {name: 'Shaan', email: 'shaan@gmail.com'},
  {name: 'Nikhil', email: 'nik@gmail.com'},
  {name: 'Amanda', email: 'amanda@gmail.com'}
]

internal_users_list.each { |user|
  user_entity = User.create(user)
  admin = rand(2)
  admin == 1 ? admin = true : admin = false
  PipelineUser.create(pipeline_id: 1, user_id: user_entity.id, admin: admin)
  PipelineUser.create(pipeline_id: 2, user_id: user_entity.id, admin: admin)
  PipelineUser.create(pipeline_id: 3, user_id: user_entity.id, admin: admin)
}

User.create([
  {name: 'Mike', email: 'mike@makersquare.com'},
  {name: 'Harsh', email: 'harsh@makersquare.com'},
  {name: 'Gilbert', email: 'gilbert@makersquare.com'},
  {name: 'Ravi', email: 'ravi@makersquare.com'},
  {name: 'Will', email: 'will@makersquare.com'}
  ])
