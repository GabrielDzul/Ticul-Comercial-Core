##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [3.1.2](https://github.com/organization/project-name/blob/master/.ruby-version#L1)
- Rails [7.1.0](https://github.com/organization/project-name/blob/master/Gemfile#L12)

##### Check out the repository

```bash
git clone git@github.com:GabrielDzul/Ticul-Comercial-Core.git
```

#### Install dependencies

```bash
bundle install
```

#### Set environment variables

Using [Figaro](https://github.com/laserlemon/figaro):

See [config/application.yml.sample](https://github.com/juliendargelos/project/blob/master/config/application.yml.sample)


#### Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.yml.sample config/database.yml
```

#### Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

#### Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

#### Access the API docs

http://localhost:3000/docs