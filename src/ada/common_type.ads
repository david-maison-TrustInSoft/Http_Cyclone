pragma Ada_2020;

with Interfaces.C; use Interfaces.C;
with System;

package Common_Type is

   MAX_BYTES : constant := 128;

   -- type IpAddr is new System.Address;

   type Bool is new Boolean;
   for Bool'Size use int'Size;

   type Systime is new unsigned;

   type Sock_Descriptor is new unsigned;
   type Sock_Type is new unsigned;
   type Sock_Protocol is new unsigned;
   type Port is range 0 .. (2**16 - 1);
   type uint8 is mod 2**8;
   subtype Index is unsigned range 0 .. MAX_BYTES;
   type Block8 is array (Index range <>) of uint8;

   -- I limit the size of the Received buffer
   type Buffer_Index is range 0 .. 1024;
   type Received_Buffer is array (Buffer_Index range <>) of char
      with Relaxed_Initialization;

   type Send_Buffer is array (Buffer_Index range <>) of char;

end Common_Type;
