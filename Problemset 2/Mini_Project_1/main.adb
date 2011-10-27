with GF2n;

type element_type is (mod 2**4);

procedure main is
package GF2_4 is new GF2n(Element => element_type);
x : GF2_4.Element; 
begin
 x:= 7;
 GF2_4.Put(x);
end main;
