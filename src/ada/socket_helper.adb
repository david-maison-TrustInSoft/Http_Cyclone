with System;

package body Socket_Helper with
   SPARK_Mode => Off
is

   procedure Get_Socket_From_Table
     (Index : in     Socket_Type_Index;
      Sock  :    out Socket)
   is

      function getSocketFromTable
        (index : unsigned)
      return Socket
        with
         Import        => True,
         Convention    => C,
         External_Name => "getSocketFromTable";

   begin
      Sock := getSocketFromTable (unsigned (Index));
   end Get_Socket_From_Table;

   -- Temporaire, à supprimer.
   -- Juste pour faire tourner gnatprove pour le moment
   procedure Get_Host_By_Name_H
     (Server_Name    :     char_array;
      Server_Ip_Addr : out IpAddr;
      Flags          :     unsigned;
      Error          : out Error_T)
   is

      function getHostByName
        (Net_Interface   :     System.Address;
         Server_Name     :     char_array;
         Serveur_Ip_Addr : out IpAddr;
         Flags           :     unsigned)
      return unsigned
        with
         Import        => True,
         Convention    => C,
         External_Name => "getHostByName";

   begin
      Error :=
        Error_T'Enum_Val
          (getHostByName
             (System.Null_Address, Server_Name, Server_Ip_Addr, Flags));
   end Get_Host_By_Name_H;

   procedure Free_Socket
      (Sock : in out Socket)
   is
      pragma Annotate (CodePeer, Skip_Analysis);
   begin
      Sock := null;
   end Free_Socket;

end Socket_Helper;
