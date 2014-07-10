# SpecRequirer

[![Gem Version](https://badge.fury.io/rb/spec_requirer.png)](http://badge.fury.io/rb/spec_requirer)
[![Code Climate](https://codeclimate.com/github/HouseTrip/spec_requirer.png)](https://codeclimate.com/github/HouseTrip/spec_requirer)
[![Build Status](https://travis-ci.org/HouseTrip/spec_requirer.png?branch=master)](https://travis-ci.org/HouseTrip/spec_requirer)
[![Coverage Status](https://coveralls.io/repos/HouseTrip/spec_requirer/badge.png?branch=master)](https://coveralls.io/r/HouseTrip/spec_requirer?branch=master)

Helps require files and manage the `$LOAD_PATH` of unit tests which do not boot
a framework.

For example in Rails if you want fast unit tests you do not boot Rails.
However this means that "app/models" etc. are not added to the `LOAD_PATH`. 
This typically means you need to either add the paths or use `require_relative`.

* Explicit requiring of files
* Additional meta-information about the required files
* Adds paths to the `LOAD_PATH`

Require only what you need, keep it light and explicit.

## Installation

```ruby
gem 'spec_requirer', group: :test, github: 'HouseTrip/spec_requirer', tag: 'v0.0.1'
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

Similarly a "uses" method is available for each component which adds a
directory to the `$LOAD_PATH`. You can then `require` the file as usual:

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

Yes, please.
