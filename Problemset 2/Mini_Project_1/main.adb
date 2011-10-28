with GF2n;

procedure main is
type Element_Type is mod 2**20;
Irreducible_P : Element_Type := Element_Type'Last;
package GF2_4 is new GF2n(Element => element_type, F => Irreducible_P);
x : element_type;

begin
 x:= 1055;
 GF2_4.Put(x);
 GF2_4.Put(Irreducible_P);
end main;
