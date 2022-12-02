with ada.text_io, ada.integer_text_io, ada.float_text_io, Ada.Command_Line, Ada.Strings.Unbounded;
use ada.text_io, ada.integer_text_io, ada.float_text_io, Ada.Command_Line, Ada.Strings.Unbounded;


procedure markov is

	--global count variable
	COUNT : Integer := 0;

	-- generates the markov sequence using a recursive branched method
	function Make_Markov(LOWER, UPPER : Long_Integer; a, b, c : Long_Integer) return Long_Integer is

	begin
		-- base cases
		if (c > UPPER) then
			return 0;
		end if;

		if(c < LOWER) then
			if (c <= 2) then
				-- top branch
				return Make_Markov(LOWER, UPPER, a, c, (3*a*c - b));
			else
				-- top and bottom branch
				return Make_Markov(LOWER, UPPER, a, c, (3*a*c - b)) + Make_Markov(LOWER, UPPER, a, c, (3*b*c - a));
			end if;
		end if;
		
		-- incrementing the global variable COUNT
		markov.COUNT := markov.COUNT + 1;

		if (c <= 2) then
			-- top branch only
			return c + Make_Markov(LOWER, UPPER, a, c, (3*a*c - b));
		else
			-- top and bottom branch
			return c +  Make_Markov(LOWER, UPPER, a, c, (3*a*c - b)) +  Make_Markov(LOWER, UPPER, a, c, (3*b*c - a));
		end if;


	end Make_Markov;

	function Markov_Range (LOWER, UPPER : Long_Integer) return Long_Integer is
		a, b, c : Long_Integer := 1;
	begin
		return Make_Markov(LOWER, UPPER, a, b, c);

	end Markov_Range;

	-- collapses a number recursively until it is in single digits	
	function Collapse(NUM : Long_Integer) return Long_Integer is

		SUM: Long_Integer := 0;
		HOLD: Long_Integer := NUM;


	begin
		if (NUM < 10) then
			return NUM;
		end if;

		while HOLD > 0 loop
			SUM := SUM + (HOLD mod 10);
			HOLD := HOLD/10;
		end loop;

		return Collapse(SUM);

	end Collapse;

		
	--translates number to Roman Numeral
	function Roman(NUM : Integer) return Unbounded_String is
		
		OUTPUT : Unbounded_String;
		HOLD : Integer := NUM;

	begin
		if (NUM = 0) then
			OUTPUT := To_Unbounded_String("N");
		else
			while HOLD > 0 loop
				if (HOLD = 9) then
					OUTPUT := OUTPUT & "IX";
					HOLD := HOLD - 9;
				elsif (HOLD >= 5) then
					OUTPUT := OUTPUT & "V";
					HOLD := HOLD - 5;
				elsif (HOLD = 4) then
					OUTPUT := OUTPUT & "IV";
					HOLD := HOLD - 4;
				else
					OUTPUT := OUTPUT & "I";
					HOLD := HOLD - 1;
				end if;

			end loop;
		end if;

		return OUTPUT;


	end Roman;




	arg1: Long_Integer;--STRING(1..50);
	arg2: Long_Integer; --STRING(1..50);

	temp:Long_Integer;

	sum: Long_Integer;
	col: Long_Integer;


begin
	if Argument_Count = 0 then
		Put_Line(Current_Error, "Error - No file names given.");
		Set_Exit_Status(Failure);
	end if;


	--takes command line input
	arg1:= Long_Integer'Value(Argument(1));
	arg2 := Long_Integer'Value(Argument(2));

	--ensures that arg1 is lower than arg2
	if(arg2 < arg1) then
		temp := arg1;
		arg1 := arg2;
		arg2 := temp;
	end if;

	--calculates sum of markov 
	sum := Markov_Range(arg1, arg2);

	--calculates collapse of the sum
	col := Collapse(sum);

	Put_Line("Count: " & Integer'Image(COUNT));
	Put_Line("Sum: " & Long_Integer'Image(sum));
	Put_Line("Collapse: " & Long_Integer'Image(col));


	Put_Line("Roman: " & To_String(Roman(Integer(col))));
	
	if ((col mod 2) /= 0) then
		Put_Line(" -- et tu Brute!");
	else
		Put_Line(" -- Hail Caesar!");
	end if;


end markov;
