My Itamae
=========

Ubuntu configuration management for Ubuntu 16.04 LTS (Xenial), and 17.10 (Artful).

PREREQUISITE
------------

If one needs to build `nodes/*.json`, and Go environment is **not** ready,
have [ghr](https://github.com/yowcow/ghr/releases) (v2.0.0 or later) executable somewhere in `$PATH`.

HOW TO USE
----------

To run configuration management, do:

```
make
```

and

```
sudo make roles/sakura   # my server
sudo make roles/vagrant  # my box
sudo make roles/galago   # my laptop
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
