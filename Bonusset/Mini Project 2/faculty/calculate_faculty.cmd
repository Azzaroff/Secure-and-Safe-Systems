9.
consult 'my_rules.rls'.
done.
infer c # 1 using my_rules.
infer c # 1 using my_rules(2).
infer fac = test(n) using my_rules(2).
consult 'my_rules.rls'.
infer c # 1 using my_rules.
6.
infer fac * i <= 2147483647 div i * i using inequals.
infer c # 1 using my_rules(1) from [13].
infer 2147483647 div i * i = 2147483647 using my_rules.
done.
.save
save.
list.
exit.
