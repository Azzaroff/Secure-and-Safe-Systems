context with rgb;    use rgb;
        with Text_IO;    use Text_IO;

***** RGB Plus small Number
define  rgb1   : Color := To_Color(0,0,0);
        rgb2   : Color := To_Color(3,2,1);
		rgb3   : Color := To_Color(3,2,1);
		Result : Color;
test   Result := rgb1 + rgb2;
pass   Result = rgb3

***** RGB Plus mid Number
define  rgb1   : Color := To_Color(1,2,3);
        rgb2   : Color := To_Color(3,2,1);
		rgb3   : Color := To_Color(4,4,4);
		Result : Color;
test   Result := rgb1 + rgb2;
pass   Result = rgb3

***** RGB Plus large Number
define  rgb1   : Color := To_Color(255,254,253);
        rgb2   : Color := To_Color(1,2,3);
		rgb3   : Color := To_Color(255,255,255);
		Result : Color;
test   Result := rgb1 + rgb2;
pass   Result = rgb3
