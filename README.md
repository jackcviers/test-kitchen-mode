test-kitchen-mode
=================

RSpec mode provides some convenience functions for dealing with test-kitchen.

## Installation

You can install via ELPA, or manually by downloading `test-kitchen-mode` and
adding the following to your init file

```elisp
(add-to-list 'load-path "/path/to/test-kitchen-mode")
(require 'test-kitchen-mode)
```

## Usage

If `test-kitchen-mode` is installed properly, it will be started automatically when `ruby-mode` is started inside of a directory with a `kitchen.yml` file.

See `test-kitchen-mode.el` for further usage.

## Contributing

I welcome any and all issues and pull-requests. Checkout the [git project](https://github.com/jackcviers/test-kitchen-mode.git), create a branch, make a change, then submit a pull request.

### Note on PR

* Fork the project
* Make a feature or bugfix branch
* Make your changes
* Tests are awesome! test-kitchen is for integration testing, afterall, so please at least add a
test, especially if you are filing an issue.
* Send a pull request. Please squash your commits into one commit, and create a branch for your
changes, and pull-request against jackcviers/test-kitchen-mode#master.

### Note on issues

* If you can, fork the project and make a test for the issue you discover.
* Make the title of the issue short and descriptive.
* Include a step-by-step description of what you were doing and how it broke so that the issue can be duplicated.
* Include what version of emacs you are using, and your os information.
* Include the version of test-kitchen-mode you are using.
* Include any customizations for test-kitchen-mode you have in your init file.
* If emacs provides you with debug information, include that.

Thanks! Happy hacking.
