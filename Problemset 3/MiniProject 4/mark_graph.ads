with Generic_Graph;

generic
   type Vertex_Type is private;
   type Vertex_Mark is (<>);
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
end Mark_Graph;
