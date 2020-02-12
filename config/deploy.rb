# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"

set :application, 'backend-petparent'
set :repo_url, 'git@github.com:petparent/backend-petparent.git'
set :deploy_to, '/home/ubuntu/backend-petparent'
set :use_sudo, true
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_files, %w{config/credentials/staging.key config/database.yml}

set :keep_releases, 5
