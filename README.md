# rustup

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with rustup](#setup)
    * [What rustup affects](#what-rustup-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with rustup](#beginning-with-rustup)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

A puppet module to install and configure `rustup`, `rustc` and `cargo` to enable complation of Rust projects.

## Setup

### What rustup affects

Installs binaries to `$HOME/.cargo/bin/` which can be used to compile Rust projects.

### Setup Requirements

TODO should we depend on an external downloader for the script instead of hardcoding `curl`?

### Beginning with rustup

#### Default setup

```puppet
include rustup
```

#### Specifying custom release, target and profile

```puppet
class { 'rustup':
	targets => ['x86_64-unknown-linux-gnu'],
	releases => ['nightly-2019-09-05'],
	profile => 'minimal',
}
```

## Usage

TODO

Include usage examples for common use cases in the **Usage** section. Show your users how to use your module to solve problems, and be sure to include code examples. Include three to five examples of the most important or common tasks a user can accomplish with your module. Show users how to accomplish more complex tasks that involve different types, classes, and functions working in tandem.

## Reference

TODO

This section is deprecated. Instead, add reference information to your code as Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your module. For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the root of your module directory and list out each of your module's classes, defined types, facts, functions, Puppet tasks, task plans, and resource types and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

TODO

In the Limitations section, list any incompatibilities, known issues, or other warnings.

## Development

TODO

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

TODO

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
