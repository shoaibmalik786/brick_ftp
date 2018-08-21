# Brickftp
[![Build Status](https://travis-ci.com/shoaibmalik786/brick_ftp.svg?branch=master)](https://travis-ci.com/shoaibmalik786/brick_ftp)
[![Coverage Status](https://coveralls.io/repos/github/shoaibmalik786/brick_ftp/badge.svg?branch=master&update=true)](https://coveralls.io/github/shoaibmalik786/brick_ftp?branch=master)

This is a [Brickftp](https://brickftp.com/)'s _official_ [REST API](https://developers.brickftp.com/) Client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'brickftp', github: 'shoaibmalik786/brick_ftp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brickftp

## Try it right away

Sign up for a [free account](https://brickftp.com/) so you can try out super secure file sharing for your business.

## Usage

For plenty of API options, see our [documentation](https://developers.brickftp.com/).

### Configuration

Login to your brickftp dashboard and find the `api_key` and your `subdomain`

After executing of the gerenrator command `rails generate brickftp:install`, you will get a file named as `brickftp.rb` under `config/initializers`.

Replace the corresponding values

```
Brickftp.configure do |config|
  config.api_key = 'xxxxxxxxxxxxxx'
  config.subdomain = 'xxxx'
end

```

### Authentication with a Session
Logging in
```
Brickftp::Session.login({
	    username: "username",
	    password: "password"
	})
```

### Users API
List users
```
Brickftp::User.list
```

Count users
```
Brickftp::User.count
```

Search users
```
Brickftp::User.search()
```

Show a user
```
BrickFtp::User.show(user_id)
```

Create a user
```
  Brickftp::User.create(username: 'test', password: 'password')
```

Update a user
```
Brickftp::User.update(user_id, {
        password: "new_password", 
        require_password_change: true
        username: 'newusername'
    })
```

Delete a user

```
Brickftp::User.delete(user_id)
```

Unlock a user if locked
```
Brickftp::User.unlock(user_id)
```

### User API Keys API
List API keys
```
Brickftp::ApiKey.list(user_id)
```
Show an API Key
```
Brickftp::ApiKey.show(id)
```
Create an API Key
```
Brickftp::ApiKey.create(id, {
	    name: "My API key", 
	    permission_set: "full"
	})
```

Delete an API Key
```
Brickftp::ApiKey.delete(id)
```

### User Public Keys API
List Public keys
```
Brickftp::PublicKey.list(user_id)
```
Show a public key
```
Brickftp::PublicKey.show(id)
```
Create a public key
```
Brickftp::PublicKey.create(id, {
	    title: "My new key",
	    public_key: "ssh-rsa AAAAB3NzaC...xxxx"
	})
```
Delete a public key
```
Brickftp::PublicKey.delete(id)
```

### Group API
List all groups
```
Brickftp::Group.list
```
Show a group
```
Brickftp::Group.show(id)
```
Create a group
```
Brickftp::Group.create({
	    name: "Chicago Office",
	    user_ids: "3,7,9"
	})
```
Update a group
```
Brickftp::Group.update(id, {
	    user_ids: "1841,2101,3001,3818,3297"
	})
```
Delete a group
```
Brickftp::Group.delete(id)
```
Create a user in a group
```
Brickftp::Group.create_user(id, {
	    user: {
	    	username: "username",
	    	email: "example@ex.com"
	    }
	})
```
Add a member to group
```
Brickftp::Group.memberships(group_id, user_id, {
	    membership: {
	    	admin: true
	    }
	})
```
Update a member in a group
```
Brickftp::Group.update_memberships(group_id, user_id, {
	    membership:{
	    	admin: false
	    }
	})
```
Remove a member in a group
```
Brickftp::Group.delete_memberships(group_id, user_id)
```


### Permissions API
List permissions
```
Brickftp::Permission.list
```
Create a permission
```
Brickftp::Permission.create({
	    path: "a/b/c/d",
	    permission: "writeonly",
	    user_id: "10"
	})
```
Delete a permission
```
Brickftp::Permission.delete(id)
```


### Notifications API
List all notifications
```
Brickftp::Notification.list
```
Create a notification
```
Brickftp::Notification.create({
	    path: "a/b/c/d",
	    user_id: "10"
	})
```
Delete a notification
```
Brickftp::Notification.delete(id)
```

### History API
Retrieve site history
```
Brickftp::History.site_history(page, per_page)
```
Or 
```
Brickftp::History.site_history(page, per_page, start_at)
```
Retrieve login history
```
Brickftp::History.login_history(page, per_page)
```
Or 
```
Brickftp::History.login_history(page, per_page, start_at)
```
Retrieve User history
```
Brickftp::History.user_history(page, per_page)
```
Or
```
Brickftp::History.user_history(page, per_page,start_at)
```
Retrieve folder history
```
Brickftp::History.folder_history(page, per_page)
```
Or
```
Brickftp::History.folder_history(page, per_page,start_at)
```
Retrieve file history
```
Brickftp::History.file_history(page, per_page)
```
Or
```
Brickftp::History.file_history(page, per_page,start_at)
```


### Bundles API
List all bundles
```
Brickftp::Bundle.list
```
Show a bundle
```
Brickftp::Bundle.show(id)
```
Create a bundle
```
Brickftp::Bundle.create({
	    paths: ["cloud/images", "backup.zip"],
	    password: "password"
	})
```
Delete a bundle
```
Brickftp::Bundle.delete(id)
```
List bundle contents
```
Brickftp::Bundle.contents("path", {
	    code: "a0b1c2d3e",
	    password: "password"
	})
```
Download one file in a bundle
```
Brickftp::Bundle.download({
	    code: "a0b1c2d3e",
	    path: "example.ext",
	    password: "password"
	})
```
Download entire bundle as ZIP
```
Brickftp::Bundle.download_zip({
	    code: "a0b1c2d3e",
	    password: "password"
	})
```

### Behaviors API
List all behaviors
```
Brickftp::Behavior.list
```
List behaviors for a folder
```
Brickftp::Behavior.list_folder(path)
```
Show a behavior
```
Brickftp::Behavior.show(path)
```
Create a behavior
```
Brickftp::Behavior.create({
	    path: "cloud/images",
	    behavior: "webhook",
	    value: ["https://d.mywebhookhandler.com"]
	})
```
Update a behavior
```
Brickftp::Behavior.update(id, {
	    value: ["https://e.mywebhookhandler.com"]
	})
```
Delete a behavior
```
Brickftp::Behavior.delete(id)
```


### File and Folder Operations API
List folder contents
```
Brickftp::Folder.list(path)
```
Create a folder
```
Brickftp::Folder.create(path_and_folder_name)
```
Count folder contents recursively
```
Brickftp::Folder.count_contents(path_and_folder_name)
```
Count folder contents non-recursively
```
Brickftp::Folder.count_nrs_contents(path_and_folder_name)
```
Get folder size
```
Brickftp::Folder.size(path_and_folder_name)
```
Download a file
```
Brickftp::Folder.download_file(path_and_folder_name)
```
Move or rename a file or folder
```
Brickftp::Folder.move_or_rename(path_and_filename,{
	    "move-destination": "/DESTINATION_PATH_AND_FILENAME.EXT"
	})
```
Copy a file or folder
```
Brickftp::Folder.copy(path_and_filename,{
	    "copy-destination": "/DESTINATION_PATH_AND_FILENAME.EXT"
	})
```
Delete a file or folder
```
Brickftp::Folder.delete(path_and_filename)
```
Depth delete a file or folder
```
Brickftp::Folder.depth_delete(path_and_filename)
```

### File Uploading API
Upload a file
```
Brickftp::Upload.create(path: "orginal_file_name", source: file)
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
