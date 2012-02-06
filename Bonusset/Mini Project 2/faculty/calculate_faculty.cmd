6.
infer fac * i <= 2147483647 div i * i using inequals.
ls
list.
infer c # 1 using inequals.
no
yes
no
no
no
no
no
no
no
no
no
no
no
no
no
no
no
no
no
no
yes
list.
replace c # 1 : 2147483647 div i * i by i * 2147483647 div i using commut.
replace c # 1 : 2147483647 div i * i by i * 2147483647 div i using inequals.
replace c # 1 : 2147483647 div i * i.
i * 2147483647 div i.
arith.
replace c # 1 : 2147483647 div i * i.
i * 2147483647 div i.
commut.
replace c # 1 : 2147483647 div i * i.
i * 2147483647 div i.
inequals.
list.

list.
consult 'my_rules.rls'.
infer c # 1 using my_rules.
.save
save.
list.
exit.
