with GF2n;

procedure main is
type element_type is mod 2**20;
Irreducible_P : element_type := 1;
package GF2_4 is new GF2n(Element => element_type, F => Irreducible_P);
x : element_type;

begin
 x:= 1055;
 GF2_4.Put(x);
end main;
