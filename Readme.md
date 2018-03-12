# Event registration Padrino rewrite

Test locally using the [`foreman` gem](https://github.com/ddollar/foreman) or the [`forego` package](https://github.com/ddollar/forego).

```bash
$ foreman start -f Procfile.local
$ forego start -f Procfile.local
```

To simulate a Heroku process configuration:

```bash
$ foreman start -f Procfile.local -m web=5,worker=2,clock=1
```