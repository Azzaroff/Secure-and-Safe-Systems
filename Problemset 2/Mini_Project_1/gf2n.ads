generic
type Element is mod <>;
F : Element ; --Irreducible_Polynomial

package GF2n is
-- Output an element as spolynomial .
-- Example output : " x ∗∗4 + x ∗∗1 + 1 " .

procedure Put ( Item : Element ) ;
function "+" ( Left : Element ; Right : Element ) return Element ;
function "-" ( Left : Element ; Right : Element ) return Element ;
function "*" ( Left : Element ; Right : Element ) return Element ;

-- Can raise contrainterror 
    function "/" ( Left : Element ; Right : Element ) return Element;

-- private

function Inverse (Item : Element) return Element;


function Shift_Left(Item : Element; Amount : Natural) return  Element;
function Shift_Right(Item : Element; Amount : Natural) return  Element;
   
pragma Import (Intrinsic, Shift_Left);
pragma Import (Intrinsic, Shift_Right);

end GF2n ; 

