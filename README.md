My Itamae
=========

Ubuntu configuration management for Ubuntu 20.04 LTS (Focal).

PREREQUISITE
------------

If one needs to build `nodes/*.json`, and Go environment is **not** ready,
have [ghr](https://github.com/yowcow/ghr/releases) (v2.0.0 or later) executable somewhere in `$PATH`.

HOW TO USE
----------

To run configuration management, do:

```
make && sudo make apply
```

HOW TO UPDATE
-------------

To update `nodes/*.json`, do:

```
make clean && make update
```

HOW TO RESET
------------

To reset all back to the original state, do:

```
make realclean && make
```
