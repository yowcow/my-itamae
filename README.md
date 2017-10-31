My Itamae
=========

My configuration management for Ubuntu 16.04.

PREREQUISITE
------------

If I need to build `nodes/common.json`, and Go environment is **not** ready,
have [vim-ver](https://github.com/yowcow/vim-ver/releases) (v1.0.0 or later) executable somewhere in `$PATH`.

HOW TO USE
----------

To run configuration management, do:

```
make
```

and

```
make roles/sakura
make roles/vagrant
make roles/server
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
