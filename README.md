# RailsZen

**AIM**: To save time by giving a boilerplate, and a thought flow.

A step by step generator. This will get *uniqueness*, *validations*  from you, and write
the appropriate files (model, migration, model_spec).

The specs generated here assumes you are using

- Rspec (>3.0)
- Shoulda matchers
- FactoryGirl

*NOTE*: You need to use this app at the root of your rails directory

*Disclamier*: Things like mocks, stubs and proper testing might not be possible with this project.
The aim is to automate as many things as possible, this is not a panacea :) .

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_zen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_zen

## Usage

### COMMANDS

####  model g (generate)

    rails_zen model g user name:string score:integer

- Once you enter this command, you will have few questions asked such as what to validate, which attribute is unique.
- Based on your input, the model, model_spec and migration files will be written

#### model act (action)

    rails_zen model act calculator sum

- When you want to add a method to your model, you could invoke this command.

- This will get inputs from you such as:
    - what the method does
    - the argument names
    - sample argument with a corresponding output

- Based on these input, a skeleton method will be written to your model file and model spec file

*OPTIONS*: If you want to write a class method you can pass --class option like this


    rails_zen model g calculator sum --class

#### Use help to see the examples

    rails_zen model g help
    rails_zen model act help

### Tip

- Create aliases for these commands in your bashrc or zshrc.
- I'm using

    alias rzmg="rails_zen model g "
    alias rzma="rails_zen model act "

```bash
rzmg user name:string score:integer
rzma user calculate_score
```
## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails_zen/fork )

    bundle binstub rspec-core
    bundle binstub cucumber

    bin/rspec
    bin/cucumber

- This project uses [thor](https://github.com/erikhuda/thor/). You could [refer this blog post](willschenk.com/making-a-command-line-utility-with-gems-and-thor/) to get a quick idea.
- To read the source code, start with `lib/cli.rb` & `bin/rails_zen`

2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Please write unit test using rspec and integeration spec using aruba/cucumber.
6. Create a new Pull Request
