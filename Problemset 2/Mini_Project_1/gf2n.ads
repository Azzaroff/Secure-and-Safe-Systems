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
    end GF2n ; 

