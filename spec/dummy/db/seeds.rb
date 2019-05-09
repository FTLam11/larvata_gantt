puts "Seed start"
entity = Entity.create!(name: 'Costa del Fronk')
owner = User.create!(name: 'Fronk')
project = LarvataGantt::Project.create!(owner: owner, typing: LarvataGantt::BasicTask.typings[:project],
                                        text: 'Dominate world', entity: entity)
task = LarvataGantt::Task.create!(owner: owner, typing: LarvataGantt::BasicTask.typings[:task],
                                  text: 'Secure the bag', parent: project.id.to_s,
                                  start_date: Time.zone.now, end_date: 1.week.from_now, entity: entity)
LarvataGantt::Link.create!(source: project, target: task, lag: 0, typing: LarvataGantt::Link.typings[:finish_to_finish])
puts "Seed finished"
