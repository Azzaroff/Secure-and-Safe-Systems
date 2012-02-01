1.
infer n * (n + 1) <= 46340 * (n + 1) using transitivity from [1].
no
infer n * n <= 46340 * n using transitivity.
no
list.
consult 'my_rules.rls'.
done.
prove.
infer n = 46340 using transitivity.
yes
yes
list.
infer c # 1 using my_rules from [1].
list.
done.
list.
save.
list.
infer integer__base_first = 2147483647 using my_rules.
no
infer integer__base_first = - 2147483648 using my_rules.
no
infer asd.
asd.
infer integer__base__first = - 2147483648 using my_rules(3).
infer integer__base__last = 2147483648 using my_rules(4).
infer integer__base__last = 2147483647 using my_rules(4).
list.
save.
infer c # 1 using transitivity.
no
list.
infer n <= positive__last using transitivity.
yes
yes
list.
infer positive__last = 2147483647 using my_rules.
done.
list.
prove.
done.
list.
infer n * (n + 1) div 2 = 1073720970 using transitivity.
yes
yes
list.
infer c # 1 using my_rules.
no
infer n * (n + 1) <= 46340 * (n + 1) using inequals.
list.
done.
prove.
list.
infer n * (n + 1) div 2 <= 46340 * (n + 1) div 2 using inequals.
yes
no
no
list.
infer 46340 * (n + 1) = 46340 * (46340 + 1) using eq.
no
list.
help replace.
replace c # 1 : n by 46340.
all.
all.
replace
c # 1.
n.
no
replace c # 1 : n by 46340 using arith.
all.
replace c # 1 : n by 46340 using eq.
all.
yes
done.
list.
replace c # 1 : n by 46340 using eq.
all.
yes
list.
prove.
done.
list.
replace c # 1 : positive__last by 2147483647 using eq.
infer positive__last = 2147483647 using my_rules.
replace c # 1 : positive__last by 2147483647 using eq.
yes
done.
list.
replace c # 2 : n by 46340 using eq.
all.
yes.
replace c # 2 : n by 46340 using eq.
list.
replace c # 3 : n by 46340 using eq.
all.
yes
list.
replace c # 2 : integer__base__first by - 2147483648 using eq.
yes
replace c # 3 : integer__base__last by 2147483647 using eq.
yes
done.
list.
.save
save.
exit
