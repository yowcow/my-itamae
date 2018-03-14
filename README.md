My Itamae
=========

My configuration management for Ubuntu 16.04 LTS, and 17.10.

PREREQUISITE
------------

If I need to build `nodes/*.json`, and Go environment is **not** ready,
have [ghr](https://github.com/yowcow/ghr/releases) (v2.0.0 or later) executable somewhere in `$PATH`.

HOW TO USE
----------

To run configuration management, do:

```
make
```

and

```
make roles/sakura   # my server
make roles/vagrant  # my box
make roles/galago   # my laptop
```

HOW TO UPDATE
-------------

To update `nodes/*.json`, do:

```
make clean && make
```

HOW TO RESET
------------

To reset all back to the original state, do:

```
make realclean && make
```
