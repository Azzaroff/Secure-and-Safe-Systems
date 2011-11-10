context with mark_graph; 	use mark_graph;
	with Text_IO;    	use Text_IO;

***** MARK_GRAPH first test
define    
            function Hash ( Item : Positive ) return Ada.Containers.Hash_Type is
               begin
                   return Ada.Containers.Hash_Type(Item);
               end Hash;

            type Route_Type is (Route1,Route2,Route3)

            package PMarked_Graphs is new Mark_Graph
            ( Vertex_Type => Positive,
              Mark_Type => Route_Type,
            "=" => "=",
            Hash => Hash);

            G : PMarked_Graphs.Graph_Type;
            V : Positive := 2;
            v_a1, v_a2 : PMarked_graphs.Graphs.Vertex_Array (1..0);
prepare    PMarked_Graphs.Graphs.Add_Vertex(G,V); 
test       v_a1 := PMarked_Graphs.Graphs.All_Vertices(G); 
pass       Length(v_a1) /= Length(v_a2)
