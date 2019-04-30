puts "Seed start"
entity = Entity.create!(name: 'Costa del Fronk')
portfolio = LarvataGantt::Portfolio.create!(entity: entity, name: 'Take over world plan')
owner = User.create!(name: 'Fronk')
project = LarvataGantt::Project.create!(owner: owner, typing: LarvataGantt::BasicTask.typings[:project],
                                        text: 'Dominate world', portfolio: portfolio)
LarvataGantt::Task.create!(owner: owner, typing: LarvataGantt::BasicTask.typings[:task],
                           text: 'Secure the bag', parent: project.id.to_s,
                           start_date: Time.zone.now, end_date: 1.week.from_now)
puts "Seed finished"
