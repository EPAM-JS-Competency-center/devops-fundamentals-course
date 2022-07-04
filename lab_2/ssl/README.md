**Key Generation Commands:**

For use key's configuration from the external file, you can use following commands:

_Unix_:
```
openssl req -new -x509 -newkey rsa:2048 -sha256 -nodes -keyout ssl_example.key -days 3653 -out ssl_example.crt -config <( cat certificate.cnf )
```

_Windows_:
```
openssl req -new -x509 -newkey rsa:2048 -sha256 -nodes -keyout ssl_example.key -days 3653 -out ssl_example.crt -config certificate.cnf
```
