Changelog
========================================

v0.9.0 - 2026-01-06
----------------------------------------

- Drop support for Ruby 3.0 [`9777a15`](https://github.com/DannyBen/mister_bin/commit/9777a15)
- Drop support for Ruby 3.1 [`7bf66d8`](https://github.com/DannyBen/mister_bin/commit/7bf66d8)
- Fix Ruby 4 support [`c4b1c11`](https://github.com/DannyBen/mister_bin/commit/c4b1c11)
- Switch from `readline` to `reline` [`4c216e2`](https://github.com/DannyBen/mister_bin/commit/4c216e2)
- Compare [`v0.8.1..v0.9.0`](https://github.com/dannyben/mister_bin/compare/v0.8.1..v0.9.0)


v0.8.1 - 2024-12-27
----------------------------------------

- Remove `require debug` [`5d96bdd`](https://github.com/DannyBen/mister_bin/commit/5d96bdd)
- Compare [`v0.8.0..v0.8.1`](https://github.com/dannyben/mister_bin/compare/v0.8.0..v0.8.1)


v0.8.0 - 2024-12-27
----------------------------------------

- Drop support for Ruby 2.x [`2fe891f`](https://github.com/DannyBen/mister_bin/commit/2fe891f)
- Load files with autoload [`8aa0d0e`](https://github.com/DannyBen/mister_bin/commit/8aa0d0e)
- Add support for command aliases [`9740b9a`](https://github.com/DannyBen/mister_bin/commit/9740b9a)
- Compare [`v0.7.6..v0.8.0`](https://github.com/dannyben/mister_bin/compare/v0.7.6..v0.8.0)


v0.7.6 - 2023-02-24
----------------------------------------

- Update exit codes [`8620a2f`](https://github.com/DannyBen/mister_bin/commit/8620a2f)
- Compare [`v0.7.5..v0.7.6`](https://github.com/dannyben/mister_bin/compare/v0.7.5..v0.7.6)


v0.7.5 - 2023-02-10
----------------------------------------

- Drop support for Ruby 2.6 [`b61456d`](https://github.com/DannyBen/mister_bin/commit/b61456d)
- Switch to DocoptNG [`419159a`](https://github.com/DannyBen/mister_bin/commit/419159a)
- Compare [`v0.7.4..v0.7.5`](https://github.com/dannyben/mister_bin/compare/v0.7.4..v0.7.5)


v0.7.3 - 2022-11-22
----------------------------------------

- Fix Command#initialize to receive args [`b88d3f4`](https://github.com/DannyBen/mister_bin/commit/b88d3f4)
- Compare [`v0.7.2..v0.7.3`](https://github.com/dannyben/mister_bin/compare/v0.7.2..v0.7.3)


v0.7.2 - 2022-11-21
----------------------------------------

- Drop support for Ruby < 2.6 [`f4ffba0`](https://github.com/DannyBen/mister_bin/commit/f4ffba0)
- Add Command#execute to allow for improved testability [`dd1a4e3`](https://github.com/DannyBen/mister_bin/commit/dd1a4e3)
- Compare [`v0.7.1..v0.7.2`](https://github.com/dannyben/mister_bin/compare/v0.7.1..v0.7.2)


<!-- break v0.6.2 -->
[v0.6.2](https://github.com/DannyBen/mister_bin/tree/v0.6.2) (2018-12-14)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.6.1...v0.6.2)

**Merged pull requests:**

- Change super --help format [\#26](https://github.com/DannyBen/mister_bin/pull/26) ([DannyBen](https://github.com/DannyBen))

[v0.6.1](https://github.com/DannyBen/mister_bin/tree/v0.6.1) (2018-12-14)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.6.0...v0.6.1)

**Merged pull requests:**

- Add ability to use --help when there are multiple commands [\#25](https://github.com/DannyBen/mister_bin/pull/25) ([DannyBen](https://github.com/DannyBen))
- Make command meta data available to outside callers [\#24](https://github.com/DannyBen/mister_bin/pull/24) ([DannyBen](https://github.com/DannyBen))

[v0.6.0](https://github.com/DannyBen/mister_bin/tree/v0.6.0) (2018-12-13)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.5.0...v0.6.0)

**Implemented enhancements:**

- Consider moving args from \#run to \#initialize and provide attr\_accessor [\#21](https://github.com/DannyBen/mister_bin/issues/21)

**Closed issues:**

- Improve test suite and examples [\#20](https://github.com/DannyBen/mister_bin/issues/20)

**Merged pull requests:**

- Move args from \#run to attr\_accessor [\#23](https://github.com/DannyBen/mister_bin/pull/23) ([DannyBen](https://github.com/DannyBen))
- Improve examples and example tests [\#22](https://github.com/DannyBen/mister_bin/pull/22) ([DannyBen](https://github.com/DannyBen))
- Allow running command by using only its first letters [\#19](https://github.com/DannyBen/mister_bin/pull/19) ([DannyBen](https://github.com/DannyBen))

[v0.5.0](https://github.com/DannyBen/mister_bin/tree/v0.5.0) (2018-12-01)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.4.1...v0.5.0)

**Merged pull requests:**

- Add ability to define command target methods [\#18](https://github.com/DannyBen/mister_bin/pull/18) ([DannyBen](https://github.com/DannyBen))

[v0.4.1](https://github.com/DannyBen/mister_bin/tree/v0.4.1) (2018-11-27)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.4.0...v0.4.1)

**Merged pull requests:**

- Fix cases where there are similar commands [\#17](https://github.com/DannyBen/mister_bin/pull/17) ([DannyBen](https://github.com/DannyBen))

[v0.4.0](https://github.com/DannyBen/mister_bin/tree/v0.4.0) (2018-11-26)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.3.1...v0.4.0)

**Merged pull requests:**

- Add support for sub-sub-commands [\#16](https://github.com/DannyBen/mister_bin/pull/16) ([DannyBen](https://github.com/DannyBen))

[v0.3.1](https://github.com/DannyBen/mister_bin/tree/v0.3.1) (2018-08-07)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.3.0...v0.3.1)

**Merged pull requests:**

- Add support for global handler [\#15](https://github.com/DannyBen/mister_bin/pull/15) ([DannyBen](https://github.com/DannyBen))

[v0.3.0](https://github.com/DannyBen/mister_bin/tree/v0.3.0) (2018-08-05)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.2.3...v0.3.0)

**Merged pull requests:**

- Complete refactor [\#14](https://github.com/DannyBen/mister_bin/pull/14) ([DannyBen](https://github.com/DannyBen))

[v0.2.3](https://github.com/DannyBen/mister_bin/tree/v0.2.3) (2018-05-18)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.2.2...v0.2.3)

**Merged pull requests:**

- Improvements round [\#13](https://github.com/DannyBen/mister_bin/pull/13) ([DannyBen](https://github.com/DannyBen))

[v0.2.2](https://github.com/DannyBen/mister_bin/tree/v0.2.2) (2018-05-05)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.2.1...v0.2.2)

**Merged pull requests:**

- Remove the need to call \#evaluate to get \#metadata [\#12](https://github.com/DannyBen/mister_bin/pull/12) ([DannyBen](https://github.com/DannyBen))

[v0.2.1](https://github.com/DannyBen/mister_bin/tree/v0.2.1) (2018-05-05)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.2.0...v0.2.1)

**Implemented enhancements:**

- Add description line to commands [\#10](https://github.com/DannyBen/mister_bin/issues/10)

**Merged pull requests:**

- Show summary when running without arguments [\#11](https://github.com/DannyBen/mister_bin/pull/11) ([DannyBen](https://github.com/DannyBen))

[v0.2.0](https://github.com/DannyBen/mister_bin/tree/v0.2.0) (2018-04-19)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.1.2...v0.2.0)

**Merged pull requests:**

- Refactor runner with basedir and isolation options [\#9](https://github.com/DannyBen/mister_bin/pull/9) ([DannyBen](https://github.com/DannyBen))
- Add CodeClimate code coverage [\#8](https://github.com/DannyBen/mister_bin/pull/8) ([DannyBen](https://github.com/DannyBen))

[v0.1.2](https://github.com/DannyBen/mister_bin/tree/v0.1.2) (2018-04-15)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.1.1...v0.1.2)

**Fixed bugs:**

- Currently this is not pluggable [\#6](https://github.com/DannyBen/mister_bin/issues/6)

**Merged pull requests:**

- Improve path search to look in PATH [\#7](https://github.com/DannyBen/mister_bin/pull/7) ([DannyBen](https://github.com/DannyBen))

[v0.1.1](https://github.com/DannyBen/mister_bin/tree/v0.1.1) (2018-04-15)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.1.0...v0.1.1)

**Merged pull requests:**

- Fix bin search for use in gems [\#5](https://github.com/DannyBen/mister_bin/pull/5) ([DannyBen](https://github.com/DannyBen))

[v0.1.0](https://github.com/DannyBen/mister_bin/tree/v0.1.0) (2018-04-15)
--------------------------------------------------------------------------------

[Full Changelog](https://github.com/DannyBen/mister_bin/compare/v0.0.2...v0.1.0)

**Implemented enhancements:**

- Add support for "header" and "footer" for main bin [\#3](https://github.com/DannyBen/mister_bin/issues/3)

**Merged pull requests:**

- Add header and footer to master bin [\#4](https://github.com/DannyBen/mister_bin/pull/4) ([DannyBen](https://github.com/DannyBen))
- Add example [\#2](https://github.com/DannyBen/mister_bin/pull/2) ([DannyBen](https://github.com/DannyBen))

[v0.0.2](https://github.com/DannyBen/mister_bin/tree/v0.0.2) (2018-04-14)
--------------------------------------------------------------------------------

**Merged pull requests:**

- Add support for named PARAMS [\#1](https://github.com/DannyBen/mister_bin/pull/1) ([DannyBen](https://github.com/DannyBen))
