raw_config = File.read("#{ENV['HOME']}/.credentials/services.yml")

github = YAML.load(raw_config)['github']

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, github['key'], github['secret']
end
