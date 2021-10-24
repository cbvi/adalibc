with Interfaces.C;
with Ada.Text_IO;

procedure c is
   package ModIO is new Ada.Text_IO.Modular_IO (Interfaces.C.unsigned);

   function Random return Interfaces.C.unsigned;
   pragma Import (C, Random, "arc4random");

   function Pledge (promises     : Interfaces.C.char_array;
                    execpromises : Interfaces.C.char_array)
                    return Interfaces.C.int;
   pragma Import (C, Pledge, "pledge");

   Ret : Interfaces.C.unsigned;
begin
   if Interfaces.C."=" (Pledge (Interfaces.C.To_C("stdio"), Interfaces.C.To_C("")), -1) then
      Ada.Text_IO.Put_Line ("pledge");
      return;
   end if;

   Ret := Random;

   ModIO.Put (Ret);
   Ada.Text_IO.New_Line;
end c;
