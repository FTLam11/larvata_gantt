# Override the belongs_to class for Entity
LarvataGantt.entity_class = 'Entity'

# Override belongs_to class for Task
LarvataGantt.owner_class = 'User'

# Add custom datetime format
Time::DATE_FORMATS[:f] = lambda { |time| time.strftime('%F') }
