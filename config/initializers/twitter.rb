### Add Twitter Integration
# This file contains initialization of the twitter client, linked directly
# to my account.
config = YAML.load_file("#{Rails.root}/config/twitter.yml")
TWITTER_CLIENT =
        Twitter::REST::Client.new(config['Twitter'])
TWITTER_MAX_LENGTH = 160
