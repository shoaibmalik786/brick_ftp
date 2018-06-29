# BrickFTP
[![Build Status](https://travis-ci.com/shoaibmalik786/brick_ftp.svg?branch=master)](https://travis-ci.com/shoaibmalik786/brick_ftp)
[![Coverage Status](https://coveralls.io/repos/github/shoaibmalik786/brick_ftp/badge.svg?branch=master)](https://coveralls.io/github/shoaibmalik786/brick_ftp?branch=master)

This is a [BrickFTP](https://brickftp.com/)'s _official_ [REST API](https://developers.brickftp.com/) Client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brick_ftp', github: 'shoaibmalik786/brick_ftp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brick_ftp

## Try it right away

Sign up for a [free account](https://brickftp.com/) so you can try out super secure file sharing for your business.

## Usage

For plenty of API options, see our [documentation](https://developers.brickftp.com/).

### Configuration

Login to your brickftp dashboard and find the `api_key` and your `subdomain`

After executing of the gerenrator command `rails generate imagekit:install`, you will get a file named as `brick_ftp.rb` under `config/initializers`.

Replace the corresponding values

```
BrickFtp.configure do |config|
  config.api_key = 'xxxxxxxxxxxxxx'
  config.subdomain = 'xxxx'
end

```

### Users API
List users
```
BrickFtp::User.list
```

Count users
```
BrickFtp::User.count
```

Search users
```
BrickFtp::User.search()
```

Show a user
```
BrickFtp::User.show(user_id)
```

Create a user
```
  BrickFtp::User.create(username: 'test', password: 'password')
```

Update a user
```
BrickFtp::User.update(user_id, {
        password: "new_password", 
        require_password_change: true
        username: 'newusername'
    })
```

Delete a user

```
BrickFtp::User.delete(user_id)
```

Unlock a user if locked
```
BrickFtp::User.unlock(user_id)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/brick_ftp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the brick_ftp project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/brick_ftp/blob/master/CODE_OF_CONDUCT.md).
