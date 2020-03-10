set :stage, :staging
set :rails_env, :staging
set :branch, 'feature/guest-pets-index'

server '52.200.18.242',
  user: 'ubuntu',
  roles: %w{web app db}
  set :ssh_options, {
    forward_agent: true,
    auth_methods: %w[publickey],
    keys: %w[~/.ssh/petparent.pem]
  }