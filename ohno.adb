with Ada.Text_IO;
with Interfaces.C;
with System;

procedure ohno is
   package IC renames Interfaces.C;

   subtype File is System.Address;
   Null_File : constant File := System.Null_Address;

   function get_errno return integer
      with
         Import => True,
         Convention => C;

   procedure set_errno(en : Interfaces.C.int)
      with
         Import => True,
         Convention => C;

   function fopen(path : IC.char_array; mode : IC.char_array) return File
      with
         Import => True,
         Convention => C;

   procedure fclose(f : File)
      with
         Import => True,
         Convention => C;

   task t1;
   task t2;
   task t3;
   task t4;

   task body t1 is
   begin
      delay 2.0;
      set_errno(77);
   end t1;

   task body t2 is
      err : integer;
      ptr : File;
   begin
      set_errno(99);
      ptr := fopen(IC.To_C("/tmp/test.dat"), IC.To_C("w"));
      delay 5.0;

      err := get_errno;
      Ada.Text_IO.Put_Line(err'Image);

      if System."/=" (ptr, Null_File) then
         fclose(ptr);
      end if;

   end t2;

   task body t3 is
   begin
      set_errno(101);
   end t3;

   task body t4 is
   begin
      set_errno(151);
   end t4;

   err : integer;
   ptr : File;
begin
   delay 1.0;
   ptr := fopen(IC.To_C("/tmp/doesntexist"), IC.To_C("r"));
   err := get_errno;
   Ada.Text_IO.Put_Line(err'Image);
   if System."/=" (ptr, Null_File) then
      fclose(ptr);
   end if;

   Ada.Text_IO.Put_Line(System.System_Name'Image);
end ohno;
