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

