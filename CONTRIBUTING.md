# How to Contribute to Vigilant
Contributions to Vigilant are always welcome!

We welcome bug reports, suggestions, and code contributions. We want Vigilant to be a game everyone enjoys and feels they can be a part of.

## Reporting Bugs
If you found a bug, please let us know about it by submitting a GitHub [issue](https://github.com/LastTalon/Vigilant/issues).

Be sure to:
* Check that an issue hasn't already been submitted about it. If you find one, please provide any additional information there.
* Provide a clear descriptive title and a detailed description of the problem
* Explain how and when the problem occurs and what steps to take to reproduce the problem
* Tag your issue appropriately to help us find and address it correctly

## Submitting Changes

### Did you write a patch that fixes a bug?
Thank you!
* Open a pull request against the `develop` branch
* Clearly describe the problem and solution in the pull request
* Include any relevant [issue](https://github.com/LastTalon/Vigilant/issues) number
* Be sure to check our [style guide](#style-guide)

### Did you intend to add a new feature or change an existing one?
Great!
* Create an [issue](https://github.com/LastTalon/Vigilant/issues) suggesting the feature. We love when people contribute, but we hate for their effort to be wasted. Discussing the issue ahead of time can ensure the code you write will be accpeted.
* Tag the issue appropriately
* Fork the project, check our [style guide](#style-guide), and start writing
* Consider opening a draft pull request against `develop` right away. This is the best way to discuss the code as you write it.
* When you're done be sure to open a pull request. Include the issue number for the associated issue.

### Did you already write a new feature or change an existing one?
We'd love to see it! We're happy you want to contribute, but please be patient and understanding with us.
* Follow the the instructions outlined in the [previous section](#did-you-already-write-a-new-feature-or-change-an-existing-one). There may be additional work to do.
* Please await feedback on your suggestion and pull request. If you notice any immediate issues you can resolve before we address them (such as [style issues](#style-guide)) you can continue working on the feature.
* Next one of two things will happen
	* We will notify you you that your feature is accepted and approve your pull request
	* We will let you know we can't add the feature (we're sorry). It may need to be changed first, or may be incompatible with other design goals.
* In the future, please start by opening discussion about the suggestion

### Did you fix something purely cosmetic?
We appreciate your enthusiasm, however cosmetic patches are unlikely to be approved. We do care about code quality (please check our [style guide](#style-guide)), but the cost of reviewing it outweighs the benefit of the change.

### About Pull Requests
If you're contributing code, a pull request should typically be made against the unstable `develop` branch. Pull requests against the stable `master` branch should generally only be made by maintainers and are reserved for releases and urgent patches.

Pull requests against the `develop` branch are squashed to create a clean history, while pull requests against the `master` branch are rebased to maintain the linear history.

## Style Guide
If you're contributing, please follow our style guide. It maintains the quality of our code and helps us work together.

### Commit Messages
* Use the present tense
* Use the imperative mood
* Reference issues and pull requests
* Capitalize the subject line and each sentence in the body
* Avoid ending the subject line with punctuation
* Avoid exceeding 72 lines

### Lua
* Use spaces around operators
	* `a + b` rather than `a+b`
* Use spaces after commas (newlines are fine, too)
	* `{1, 2, 3}` rather than `{1,2,3}`
* Avoid spaces inside brackets (parentheses, square brackets, curly braces, etc.)
	* `(a + b)` rather than `( a + b )`
	* `function(a, b)` rather than `function( a, b )`
	* `a[b]` rather than `a[ b ]`
* Avoid spaces between names or the function keyword and associated brackets (such as when calling functions, or indexing tables)
	* `function a(b)` rather than `function a (b)`
	* `function(a)` rather than `function (a)`
	* `a[b]` rather than `a [b]`
* Include a blank line between functions
* Use parentheses to improve clarity
* Indent using tabs, align using spaces
* Use camel case for all names, except where doing so would be prohibitive or confusing
* Begin names with a capital letter for names that are intended to be global or public
* Begin names with a lower case letter for names that are intended to be local or private
* Capitalize initialisms and acronyms, except when they are the first word of a name that would start with a lower case letter
	* `getID` rather than `getId`
	* `jsonString` rather than `JSONString`
* Keep your code orderly ([Boilerplate.lua](Boilerplate.lua) can help with this, especially for new files)
* Document your changes

## Documentation
Contributing to our documentation is a huge help. Unfortunately there isn't much to our documentation at the moment. We roughly follow [LuaDoc](https://keplerproject.github.io/luadoc/) in the source, but we're still deciding how to proceed, so we have no generated documentation.

Documentation changes can be submitted the same as any [code change](#submitting-changes).

## Releases
Releases for Vigilant are made by a maintainer using a release branch and a pull request.
1. Create a new branch from `develop`
2. Update [`CHANGELOG.md`](CHANGELOG.md)
3. Create a pull request against `master`
4. Review before release to keep `master` stable
5. Make any necessary changes (be sure to keep [`CHANGELOG.md`](CHANGELOG.md) accurate)
6. Rebase and merge the pull request
7. Tag according to [versioning](#Versioning) guidelines
8. Upload the new version to Roblox
9. Write GitHub release notes

### Versioning
Vigilant uses [semantic versioning](https://semver.org/).
* Version tags should be prepended with a `v`
	* `v0.5.12`
* The major version should increment when changes break backward compatibility
	* `v0.5.12` -> `v1.0.0`
* The minor version should increment when features are added
	* `v0.5.12` -> `v0.6.0`
* The patch version should increment when only bug fixes are added
	* `v0.5.12` -> `v0.5.13`
* A pre-release version may be included by appending a hyphen followed by dot-separated identifiers
	* `v0.5.12` -> `v0.6.0-alpha.1`
	* `v0.5.12` -> `v1.0.0-rc.1`
