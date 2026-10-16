server ENV.fetch('APPS01_HOST', '92.222.193.105'),
       user: 'ss-calculator', roles: %w[app db web], primary: true
set :branch, ENV.fetch('DEPLOY_BRANCH', 'codex/ubuntu-upgrade')
set :deploy_to, '/srv/www/ss-calculator-staging'
set :rails_env, 'production'
set :linked_files, %w[.env]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets storage public/system public/uploads]
set :bundle_path, -> { shared_path.join('bundle') }
set :ssh_options, { forward_agent: true, auth_methods: %w[publickey] }
