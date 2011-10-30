with GF2n, Ada.Text_IO;

procedure main is
type Element_Type is mod 2**9; --Irreducible needs 1 bit more
Irreducible_P : Element_Type := 2#100011011#; --aus AES 100011011
package GF2_4 is new GF2n(Element => element_type, F => Irreducible_P);
x,y,z : element_type;

begin
 x:= 16#53#;
 y:= 16#ca#;
 z:= 2;
 GF2_4.Put(x);
 GF2_4.Put(GF2_4."*"(x,y)); -- solte 1 sein :-/
 GF2_4.Put(y*z);
 GF2_4.Put(x*z);
 GF2_4.Put(Irreducible_P);
 Ada.Text_IO.Put("Inverse von ");
 GF2_4.Put(x);
 Ada.Text_IO.Put("ist:");
 GF2_4.Put(GF2_4.Inverse(x));
 Ada.Text_IO.Put("Das Produkt aus der Inversen  von x und x sollte 1 sein und ist: ");
 GF2_4.Put(x * GF2_4.Inverse(x));
 Ada.Text_IO.Put("Division: ");
 GF2_4.Put(x);
 Ada.Text_IO.Put(" / ");
 GF2_4.Put(y);
 Ada.Text_IO.Put(" = ");
 GF2_4.Put(GF2_4."/"(x,y));
end main;
