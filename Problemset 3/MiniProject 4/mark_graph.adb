package body mark_graph is

procedure Set_Mark(Graph  : in out Graph_Type; 
                      Vertex : in     Vertex_Type;
                      To     : in     Vertex_Mark) is

begin
    Maps.Insert(Maps.Map(Graph.Map),Key => Vertex, New_Item => To);
end Set_Mark;

function Get_Mark (Graph  : Graph_Type;
                   Vertex : Vertex_Type) return Vertex_Mark is
begin
    return Maps.Element(Maps.Map(Graph.Map),Vertex);
end Get_Mark;

end mark_graph;

