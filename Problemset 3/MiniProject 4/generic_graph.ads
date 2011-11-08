with Ada.Containers.Doubly_Linked_Lists;

generic
   type Vertex_Type is private;
package Generic_Graph is
   type Graph_Type is tagged limited private;
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
   -- implementation dependent ...
   
   type Edge_Type is record
		weight : Edge_Weight;
		head : Vertex_Type;
		tail : Vertex_Type;
   end record;

   package Vertex_Lists is new Ada.Containers.Doubly_Linked_Lists
   	(Element_Type => Vertex_Type);
  
   type Vertex_List is new Vertex_Lists.List with null record;
  
   package Edge_Lists is new Ada.Containers.Doubly_Linked_Lists
   	(Element_Type => Edge_Type);
  
   type Edge_List is new Edge_Lists.List with null record;
   
   type Graph_Type is tagged limited record 
   		vertices : Vertex_List;
		edges : Edge_List;
   end record;
end Generic_Graph;
