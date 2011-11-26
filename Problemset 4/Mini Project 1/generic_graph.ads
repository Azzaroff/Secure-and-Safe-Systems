private with Ada.Containers.Indefinite_Doubly_Linked_Lists;

generic
   type Vertex_Type is private;
package Generic_Graph is
   type Graph_Type is tagged private;
   subtype Edge_Weight is Natural;
   type Vertex_Array is array (Positive range <>) of Vertex_Type;
   
   -- turns the graph into an empty graph without vertices and edges
   procedure Clear (Graph : in out Graph_Type);

   
   -- inserts new Vertex; raises Constraint_Error if Vertex is already there
   -- the new Vertex is unmarked
   procedure Add_Vertex (Graph  : in out Graph_Type; Vertex : in Vertex_Type);
   
   
   -- inserts an Edge into the graph, raises Constraint error if Head or 
   -- Tail aren't already in the graph; overwrites an Edge if it already 
   -- exists (i.e., changes the weight) 
   procedure Add_Edge (Graph: in out Graph_Type;
                       Head, Tail: in Vertex_Type;
                       Weight: in Edge_Weight);

   -- returns the weight of an edge; Natural'Last if the Edge doesn't exist
   function Weight_Of (Graph: Graph_Type;
		       Head, Tail: Vertex_Type) return Edge_Weight;

   -- all nodes K with an edge from Vertex to K
   function Successors (Graph  : Graph_Type;
                        Vertex : Vertex_Type) return Vertex_Array;
   
   -- all nodes K with an edge from K to Vertex
   function Predecessors (Graph  : Graph_Type;
                          Vertex : Vertex_Type) return Vertex_Array;
   
   -- return all vertices in the Graph
   function All_Vertices(Graph : Graph_Type) return Vertex_Array;


private

type Edge_Type is 
   record
      Head: Vertex_Type;
      Tail: Vertex_Type;
      Weight: Edge_Weight;
   end record;

package Vertex_List is new Ada.Containers.Indefinite_Doubly_Linked_Lists
  (Element_Type => Vertex_Type, "=" => "=");
package Edge_List is new Ada.Containers.Indefinite_Doubly_Linked_Lists
  (Element_Type => Edge_Type, "=" => "=");

type Graph_Type is tagged 
   record
      Vertices: Vertex_List.List;
      Edges   : Edge_List.List;
   end record;

function To_Array(Vertices : Vertex_List.List) return Vertex_Array;

end Generic_Graph;
