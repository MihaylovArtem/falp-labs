domains
s = string
c = char
i=integer
li = i*

database - eras
rule(s,li)
cond(i,s)

database - answers
cond_is(integer,char)

goal
assert(cond(1,"tyrannosaur")),
assert(cond(2,"diplodocus")),
assert(cond(3,"pterodactyl")),
assert(rule("Mesozoic",[1,2,3])),
save("eras.ddb",eras).