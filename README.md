# Electronic Flight Cards

[![Build Status](https://travis-ci.org/getabetterpic/flight_cards.svg?branch=master)](https://travis-ci.org/getabetterpic/flight_cards)

## Getting Started

### Install Ruby

First you'll need Ruby installed. The simplest way to do this in a unix
environment is to install a Ruby version manager like
[rvm](https://rvm.io/rvm/install) or
[rbenv](https://github.com/rbenv/rbenv#installation). Once one of those
are installed, follow the directions for that version manager
for installing Ruby 2.5.3. For rvm it will look like this:
```bash
rvm install 2.5.3
```

### Install dependencies

You'll need to install PostgreSQL for the database.
```bash
sudo apt install postgresql postgresql-contrib
```
And the Bundler gem for handling Ruby dependencies.
```bash
gem install bundler
```

Now that Ruby and Postgres are installed, clone this repo to the place you want to
run it from (`/srv/www` is one option).
```bash
git clone git@github.com:getabetterpic/flight_cards.git
```

Once it's cloned, `cd` into the repo and run `bundle install`
to install the Ruby dependencies. This may take a while.

### Set up the database

Before we can set up the database, we need to add a new Postgres user. The
most straightforward way is to set up a user with the same name as the Linux
user you're going to use to run the server. If this is on a Raspberry Pi, 
the user is normally `pi` so we'll use that in these examples.

First switch to the `postgres` user (this should have been created when installing Postgres).
All following commands to set up the new Postgres user should be run under this `postgres`
Linux user. 
```bash
sudo su postgres
```

Now create the `pi` database user and give it access to create databases:
```bash
createuser pi --createdb -P
```
The `-P` option will make it prompt for a password. Remember this password,
we'll need it soon.

Now we can exit out of the postgres Linux user:
```bash
exit
```

Now with the database user created, we need to add the password somewhere
the server can access it. We'll put it in an environment variable that is
referenced by the `config/database.yml` file. Open up the `pi` Linux user's
`.bashrc` file and add the following line:
```bash
export POSTGRES_DEV_PASSWORD=<password for database user>
```
Save the file and close it.

We should be able to create the database now. Back in the dir where you
cloned the repo, run `rake db:create` to create the database and
`rake db:migrate` to add the tables.

### Install NGINX

Here's a good article on how to do this:

https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04

#### Additional steps

* Point NGINX to serve port 80 to the unix socket Puma (the Rails application server) will be using.
  * This will be `unix:///tmp/puma.sock`.
* Precompile assets with `rake assets:precompile`
* Boot the Rails server with `puma -b unix:///tmp/puma.sock` (you'll need to be in the Rails app directory for this)
