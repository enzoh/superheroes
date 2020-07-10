## Superheroes

[![Build Status](https://travis-ci.org/enzoh/superheroes.svg?branch=master)](https://travis-ci.org/enzoh/superheroes?branch=master)

A simple example that demonstrates how to build a [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) application on the Internet Computer using Motoko and React. 

### Demo

Start a local internet computer.

```
dfx start
```

Execute the following commands in another tab.

```
dfx build
dfx canister install --all
open "http://127.0.0.1:8000/?canisterId=$(dfx canister id www)"
```

Observe the CRUD application running in your web browser.

[![Result](img/demo.png)](http://www.youtube.com/watch?v=ioCW-9C8feE)
