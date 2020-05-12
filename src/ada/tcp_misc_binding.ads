with Common_Type;  use Common_Type;
with Error_H;      use Error_H;
with Interfaces.C; use Interfaces.C;
with Socket_Types; use Socket_Types;
with Tcp_Type;     use Tcp_Type;

package Tcp_Misc_Binding with
   SPARK_Mode
is

   procedure Tcp_Change_State
      (Sock      : in out Not_Null_Socket;
       New_State : in     Tcp_State)
      with
        Depends => (Sock =>+ New_State);

   procedure Tcp_Wait_For_Events
      (Sock       : in out Not_Null_Socket;
       Event_Mask : in     Socket_Event;
       Timeout    : in     Systime;
       Event      :    out Socket_Event)
      with
         Depends =>
           (Sock  =>+ (Event_Mask, Timeout),
            Event =>  (Event_Mask, Timeout));

   procedure Tcp_Write_Tx_Buffer
      (Sock    : in out Not_Null_Socket;
       Seq_Num :        unsigned;
       Data    :        char_array;
       Length  :        unsigned)
      with
        Import        => True,
        Convention    => C,
        External_Name => "tcpWriteTxBuffer";

   procedure Tcp_Delete_Control_Block
      (Sock : in out Not_Null_Socket)
      with
        Import        => True,
        Convention    => C,
        External_Name => "tcpDeleteControlBlock",
        Global        => null;

   procedure Tcp_Send_Segment
      (Sock         : in out Not_Null_Socket;
       Flags        :        uint8;
       Seq_Num      :        unsigned;
       Ack_Num      :        unsigned;
       Length       :        unsigned_long;
       Add_To_Queue :        Bool;
       Error        :    out Error_T)
      with
        Depends =>
            (Sock  =>+ (Flags, Seq_Num, Ack_Num, Length, Add_To_Queue),
             Error =>  (Sock, Flags, Seq_Num, Ack_Num, Length, Add_To_Queue));

   procedure Tcp_Update_Events
      (Sock : in out Not_Null_Socket)
      with
         Import => True,
         Convention => C,
         External_Name => "tcpUpdateEvents",
         Global => null;

end Tcp_Misc_Binding;
