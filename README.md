My Itamae
=========

My configuration management.

PREREQUISITE
------------

If one needs to build `nodes/common.json`, and Go environment is **not** ready,
have [vim-ver](https://github.com/yowcow/vim-ver/releases) (v1.0.0 or later) executable somewhere in `$PATH`.

HOW TO USE
----------

To run configuration management, do:

```
make
```

and

```
make sakura
make vagrant
make server
```

HOW TO UPDATE
-------------

To update `nodes/common.json`, do:

```
make clean && make
```

HOW TO RESET
------------

To reset all back to the original state, do:

```
make realclean && make
```
