context with rgb;    use rgb;


***** RGB Plus small Number
define  rgb1   : Color := To_Color(1,2,3);
        rgb2   : Color := To_Color(3,2,1);
		rgb3   : Color := To_Color(4,4,4);
		Result : Color;
test   Result := rgb1 + rgb2;
pass   Result = rgb3;

