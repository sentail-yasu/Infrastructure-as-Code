set :branch, ENV['BRANCH'] || 'master'
set :rails_env, 'production'
server 'localhost', user: 'app_name', roles: %w{app db web}
set :ssh_options, keys: '~/.ssh/id_rsa'