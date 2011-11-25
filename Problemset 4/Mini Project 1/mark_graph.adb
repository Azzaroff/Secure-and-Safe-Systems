package body Mark_Graph is

   ------------------------------------------------------------------
   
   procedure Clear (Graph : in out Graph_Type) is
   begin
      Graphs.Clear(Graphs.Graph_Type(Graph));
      Graph.Marked_Vertices.Clear;
   end Clear;
   
   ---------------------------------------------------------------
   function Contains_Vertex(Vertices : in Graphs.Vertex_Array;
			    Vertex   : in Vertex_Type)
			   return Boolean is
   begin
      for I in Vertices'Range loop
	 if Vertex = Vertices(I) then
	    return True;
	 end if;
      end loop;
      return False;
   end Contains_Vertex;
   
   ---------------------------------------------------------------
   procedure Set_Mark(Graph  : in out Graph_Type; 
                      Vertex : in     Vertex_Type;
                      To     : in     Vertex_Mark) is
      use type Mark_List.Cursor;
      Mark_Iterator : Mark_List.Cursor := Graph.Marked_Vertices.First;
   begin
      if not Contains_Vertex(Graph.All_Vertices, Vertex) then
	 raise Constraint_Error;
      end if;
      while Mark_Iterator /= Mark_List.No_Element loop
	 if Mark_List.Element(Mark_Iterator).Marked_Vertex = Vertex then
	    Graph.Marked_Vertices.Delete(Mark_Iterator);
	    exit;
	 end if;
	 Mark_Iterator := Mark_List.Next(Mark_Iterator);
      end loop;
      Graph.Marked_Vertices.Append((To, Vertex));
   end Set_Mark;
   
   ---------------------------------------------------------------
   function Get_Mark (Graph  : Graph_Type;
                      Vertex : Vertex_Type) return Vertex_Mark is
      use type Mark_List.Cursor;
      Mark_Iterator : Mark_List.Cursor := Graph.Marked_Vertices.First;
   begin
      if not Contains_Vertex(Graph.All_Vertices, Vertex) then
	 raise Constraint_Error;
      end if;
      
      while Mark_Iterator /= Mark_List.No_Element loop
	 if Mark_List.Element(Mark_Iterator).Marked_Vertex = Vertex then
	    return Mark_List.Element(Mark_Iterator).Mark;
	 end if;
	 Mark_Iterator := Mark_List.Next(Mark_Iterator);
      end loop;
      return Vertex_Mark'Last;
   end Get_Mark;

end Mark_Graph;
