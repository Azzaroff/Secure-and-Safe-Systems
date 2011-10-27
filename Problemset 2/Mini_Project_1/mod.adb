with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure mod_test is
type unsigned_4 is mod 2**4;
x,y:unsigned_4 ; 
begin
 x := 12;
 y := 5;
 Put(Integer(x+y));
end mod_test;
