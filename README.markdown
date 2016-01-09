# pstore_pp

Pretty-prints the contents of a [PStore](http://ruby-doc.org/stdlib/libdoc/pstore/rdoc/PStore.html) file as JSON.

This tool was partially inspired by [json_pp](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/json_pp.1.html).

## Installation

    $ gem install pstore_pp

## Usage

Given a PStore file `database.pstore` with a root 'foo' that has a value 'bar', and another root 'some' with the value 'thing', calling pstore_pp on it would yield the following result:

  $ pstore_pp database.pstore
  {"foo":"bar","some":"thing"}

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pstore_pp. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

This project follows the [Pull Request Hack](http://felixge.de/2013/03/11/the-pull-request-hack.html) - you can get commit access after your fist contribution to the project.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
