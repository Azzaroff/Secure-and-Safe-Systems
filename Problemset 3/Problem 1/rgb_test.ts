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

***** RGB Plus zero Number
define  rgb1   : Color := To_Color(0,0,0);
        rgb2   : Color := To_Color(1,2,3);
		rgb3   : Color := To_Color(1,2,3);
		Result : Color;
test   Result := rgb1 + rgb2;
pass   Result = rgb3

***** RGB Minus small Number
define  rgb1   : Color := To_Color(0,0,0);
        rgb2   : Color := To_Color(1,2,3);
		rgb3   : Color := To_Color(0,0,0);
		Result : Color;
test   Result := rgb1 - rgb2;
pass   Result = rgb3

***** RGB Minus mid Number
define  rgb1   : Color := To_Color(127,63,42);
        rgb2   : Color := To_Color(47,11,30);
		rgb3   : Color := To_Color(80,52,12);
		Result : Color;
test   Result := rgb1 - rgb2;
pass   Result = rgb3

***** RGB Minus large Number
define  rgb1   : Color := To_Color(255,255,255);
        rgb2   : Color := To_Color(12,13,14);
		rgb3   : Color := To_Color(243,242,241);
		Result : Color;
test   Result := rgb1 - rgb2;
pass   Result = rgb3

***** RGB Multiply small Number
define  rgb1   : Color := To_Color(0,0,0);
        rgb2   : Color := To_Color(1,2,3);
		rgb3   : Color := To_Color(0,0,0);
		Result : Color;
test   Result := rgb1 * rgb2;
pass   Result = rgb3

***** RGB Multiply mid Number
define  rgb1   : Color := To_Color(54,23,101);
        rgb2   : Color := To_Color(2,3,2);
		rgb3   : Color := To_Color(108,69,202);
		Result : Color;
test   Result := rgb1 * rgb2;
pass   Result = rgb3

***** RGB Multiply large Number
define  rgb1   : Color := To_Color(127,23,67);
        rgb2   : Color := To_Color(5,54,12);
		rgb3   : Color := To_Color(255,255,255);
		Result : Color;
test   Result := rgb1 * rgb2;
pass   Result = rgb3
