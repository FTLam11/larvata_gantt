# Override the belongs_to class for Portfolio here
LarvataGantt.entity_class = 'Entity'
LarvataGantt.owner_class = 'User'

# Add custom datetime format
Time::DATE_FORMATS[:f] = lambda { |time| time.strftime('%F') }
