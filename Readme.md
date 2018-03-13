# Event registration Padrino rewrite

[![Build Status](https://travis-ci.org/thewpaney/eventreg.svg?branch=padrino)](https://travis-ci.org/thewpaney/eventreg)
[![Inline docs](http://inch-ci.org/github/thewpaney/eventreg.svg?branch=padrino)](http://inch-ci.org/github/thewpaney/eventreg)

Test locally using the [`foreman`](https://github.com/ddollar/foreman) gem or the [`forego`](https://github.com/ddollar/forego) package.

```bash
$ foreman start -f Procfile.local
$ forego start -f Procfile.local
```

To simulate a Heroku process configuration:

```bash
$ forego start -f Procfile.local -m web=5,worker=2,clock=1
```