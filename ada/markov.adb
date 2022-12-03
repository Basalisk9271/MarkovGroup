with ada.text_io, ada.integer_text_io, Ada.Containers,  Ada.Containers.Ordered_Sets,  Ada.Command_Line, Ada.Strings.Unbounded;
use ada.text_io, ada.integer_text_io, Ada.Containers, Ada.Command_Line, Ada.Strings.Unbounded;


with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;
--with Ada.Containers; use Ada.Containers;
--with Ada.Containers.Ordered_Sets;

procedure markov is

	--global count variable
--	COUNT : Integer := 0;

	-- defines a Set of Long_Integers to hold the Markov numbers
	package Collatz_Vector is new Ada.Containers.Vectors  (Index_Type   => Natural, Element_Type => Long_Integer);

	use Collatz_Vector;


	-- determines if the three numbers are a Markov chain
	function Is_Markov(X,Y,Z : Long_Integer) return Boolean is

		begin

		if(X ** 2 + Y ** 2 + Z ** 2 = 3 * X * Y * Z) then
			return TRUE;
		else
			return FALSE;
		end if;
	end Is_Markov;


	-- generates a set of the markov numbers between the Lower and Upper Value
	function Gen_Markov(LOWER,UPPER : Long_Integer) return Vector is
		Collatz_Nums : Vector;

		begin
			for i in LOWER..UPPER loop
				for j in 0..UPPER loop
					for k in 0..UPPER loop

						if(Is_Markov(i,j,k)) then
							--add the number that is between lower and upper to the set only if it is not already included
							if (not Collatz_Nums.Contains(i)) then
								Collatz_Nums.Append(i);
							end if;
						end if;
					end loop;
				end loop;
			end loop;

			return Collatz_Nums;



	end Gen_Markov;



	-- generates the markov sequence using a recursive branched method
--	function Make_Markov(LOWER, UPPER : Long_Integer; a, b, c : Long_Integer) return Long_Integer is
--
--	begin
--		-- base cases
--		if (c > UPPER) then
--			return 0;
--		end if;
--
--		if(c < LOWER) then
--			if (c <= 2) then
--				-- top branch
--				return Make_Markov(LOWER, UPPER, a, c, (3*a*c - b));
--			else
--				-- top and bottom branch
--				return Make_Markov(LOWER, UPPER, a, c, (3*a*c - b)) + Make_Markov(LOWER, UPPER, a, c, (3*b*c - a));
--			end if;
--		end if;
--		
--		-- incrementing the global variable COUNT
--		markov.COUNT := markov.COUNT + 1;
--
--		if (c <= 2) then
--			-- top branch only
--			return c + Make_Markov(LOWER, UPPER, a, c, (3*a*c - b));
--		else
--			-- top and bottom branch
--			return c +  Make_Markov(LOWER, UPPER, a, c, (3*a*c - b)) +  Make_Markov(LOWER, UPPER, a, c, (3*b*c - a));
--		end if;
--
--
--	end Make_Markov;

	
	-- function accesible by the user to begin calculating the Markov numbers
--	function Markov_Range (LOWER, UPPER : Long_Integer) return Long_Integer is
--		a, b, c : Long_Integer := 1;
--	begin
--		return Make_Markov(LOWER, UPPER, a, b, c);
--
--	end Markov_Range;

	function Sum_Vector( V : Vector) return Long_Integer is
		SUM : Long_Integer := 0;

	begin
		for I in V.First_Index .. V.Last_Index loop
			SUM := SUM + V.Element (I);


		end loop;

		return SUM;

	end Sum_Vector;



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


	arg1: Long_Integer;
	arg2: Long_Integer;

	temp:Long_Integer;

	sum: Long_Integer;
	col: Long_Integer;

	output : Vector;

begin
	if Argument_Count = 0 then
		Put_Line(Current_Error, "Error");
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


	--calculates number of markov sequence numbers iteratively
	output := Gen_Markov(arg1, arg2);

   for I in output.First_Index .. output.Last_Index loop
      --  Displaying current index I
             Put ("- ["
                         & Extended_Index'Image (I)
                                    & "] ");
      
                                         Put (Long_Integer'Image (output (I)));
      --
      --                                          --  We could also use the V.Element (I)
      --                                                --  function to retrieve the element at
      --                                                      --  the current index I
      --
                                                                  New_Line;
                                                                     end loop;



	--calculates sum of markov sequence numbers in the vector
	sum := Sum_Vector(output);

	--calculates collapse of the sum
	col := Collapse(sum);

	Put_Line("Count: " & Count_Type'Image(output.Length));
--	Put_Line("Count: " & Integer'Image(COUNT));
	Put_Line("Sum: " & Long_Integer'Image(sum));
	Put_Line("Collapse: " & Long_Integer'Image(col));
	Put_Line("Roman: " & To_String(Roman(Integer(col))));
	
	if ((col mod 2) /= 0) then
		Put_Line(" -- et tu Brute!");
	else
		Put_Line(" -- Hail Caesar!");
	end if;



end markov;
