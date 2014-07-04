require "spec_requirer"

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.before { SpecRequirer.configuration.clear }

  # reset $LOAD_PATH after each spec
  config.around do |example|
    load_paths_before = $LOAD_PATH
    example.run
    $LOAD_PATH.each do |path|
      $LOAD_PATH.delete(path) unless load_paths_before.include?(path)
    end
  end
end
