with Generic_Graph;
with Ada.Containers.Indefinite_Hashed_Maps;

generic
   type Vertex_Type is private;
   type Vertex_Mark is (<>);
   with function "=" (X, Y: Vertex_Type ) return Boolean is <>;
   with function Hash ( Item : Vertex_Type ) return Ada.Containers.Hash_Type is <>;

package Mark_Graph is
 
   package Graphs is new Generic_Graph(Vertex_Type);

   type Graph_Type is new Graphs.Graph_Type with private;

   procedure Set_Mark(Graph  : in out Graph_Type; 
                      Vertex : in     Vertex_Type;
                      To     : in     Vertex_Mark);

   function Get_Mark (Graph  : Graph_Type;
                      Vertex : Vertex_Type) return Vertex_Mark;

private
    -- implementation dependent ..
    package Maps is new Ada.Containers.Indefinite_Hashed_Maps
        ( Key_Type => Vertex_Type,
          Element_Type => Vertex_Mark,
          Hash => Hash,
          Equivalent_Keys => "=" );

    type Mark_Map is new Maps.Map with null record; 

    type Graph_Type is new Graphs.Graph_Type with record
        Map : Mark_Map;
    end record;


end Mark_Graph;
