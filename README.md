# SpecRequirer

[![Gem Version](https://badge.fury.io/rb/spec_requirer.png)](http://badge.fury.io/rb/spec_requirer)
[![Code Climate](https://codeclimate.com/github/krisleech/spec_requirer.png)](https://codeclimate.com/github/krisleech/spec_requirer)
[![Build Status](https://travis-ci.org/krisleech/spec_requirer.png?branch=master)](https://travis-ci.org/krisleech/spec_requirer)
[![Coverage Status](https://coveralls.io/repos/krisleech/spec_requirer/badge.png?branch=master)](https://coveralls.io/r/krisleech/spec_requirer?branch=master)

Helps require files and manage the `LOAD_PATH` of application unit tests which 
do not boot the framework.

For example in Rails if you want fast unit tests you do not boot Rails.
However this means that "app/models" etc. are not added to the `LOAD_PATH`. 
This typically means you need to either add the paths or use `require_relative`.

* Explicit requiring of files
* Additional meta-information about the required files
* Adds paths to the `LOAD_PATH`

Require only what you need, keep it light and explicit.

## Installation

```ruby
gem 'spec_requirer', group: :test, github: 'krisleech/requirer', tag: 'v0.0.1'
```

This is not released to Rubygems yet.

## Usage

In your `test_helper` / `spec_helper`:

```ruby
require 'pathname'
require 'spec_requirer'

SpecRequirer.setup(app_root: Pathname(File.dirname(__FILE__)).join('..'),
                   components: ['models', 'services', 'presenters'])
```

In a Rails app the `app_root` would be the `app` directory.

### Require helpers

For each component a require helper is added which lets you do:

```ruby
require_models 'user', 'reward', 'prize'

require_presenters 'user_presenter'

require_services 'create_user'
```

### $LOAD_PATH helpers

Similarly a "uses" method is added which adds a directory to the `$LOAD_PATH`:

```ruby
uses_models
uses_presenters
uses_services

require 'user'
require 'user_presenter'
require 'create_user'
```

Or you can use the one-line version as such:

```ruby
uses :models, :presenters, :services
```

## Configuration

Commented out options are not yet implemented.

```ruby
require 'pathname'
require 'spec_requirer'

SpecRequirer.configure do |config|
  config.app_root = Pathname(__FILE__).join('..')
  # config.add_components(in: ‘app’, except: %’w(views, assets))
  # config.add_component('config/initializers', as: 'initializer')
  # config.patch_kernel = true
end

SpecRequirer.setup
```

You can also pass some configuration directly to `setup` as such:

```ruby
SpecRequirer.setup(app_root: app_root, components: ['models', 'presenters'])
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/spec_requirer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
