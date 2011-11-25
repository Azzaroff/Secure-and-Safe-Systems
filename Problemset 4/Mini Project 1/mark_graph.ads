private with Ada.Containers.Indefinite_Doubly_Linked_Lists;
with Generic_Graph;

generic
   type Vertex_Type is private;
   type Vertex_Mark is (<>);
   
package Mark_Graph is
   
   package Graphs is new Generic_Graph(Vertex_Type);
   
   type Graph_Type is new Graphs.Graph_Type with private;
   
   -- marks Vertex with Mark; raises Constraint_Error if
   -- Vertex is not part of the Graph
   procedure Set_Mark(Graph  : in out Graph_Type; 
                      Vertex : in     Vertex_Type;
                      To     : in     Vertex_Mark);
   
   -- returns the mark of Vertex;
   -- raises Constraint_Error if Vertex is not part of the Graph;
   -- returns Vertex_Mark'Last if Vertex is part of the Graph,
   -- but not yet marked
   function Get_Mark (Graph  : Graph_Type;
                      Vertex : Vertex_Type) return Vertex_Mark;
   overriding
   procedure Clear (Graph : in out Graph_Type);
   
private
   type Mark_Type is
      record
	 Mark: Vertex_Mark;
	 Marked_Vertex: Vertex_Type;
      end record;
   
   package Mark_List is new Ada.Containers.Indefinite_Doubly_Linked_Lists
     (Element_Type => Mark_Type, "=" => "=");
   
   type Graph_Type is new Graphs.Graph_Type with
      record
	 Marked_Vertices: Mark_List.List;
      end record;
   
   function Contains_Vertex(Vertices : in Graphs.Vertex_Array;
			    Vertex   : in Vertex_Type)
			   return Boolean;
end Mark_Graph;
