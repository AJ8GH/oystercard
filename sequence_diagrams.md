```flow
alias u="User"
alias c="Oyster"
alias j="Journey"

u->c: "touch_in(station)"
c->j: "Journey.new(station, nil)"
j-->c: "journey"
c->c: "journeys << journey"
u->c: "touch_out(station)"
c->c: "update journey"
```
