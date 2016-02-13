unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, CPort,
  Vcl.Buttons, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, Vcl.Menus;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    ComPort1: TComPort;
    Label6: TLabel;
    TrackBar4: TTrackBar;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    Label10: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    TrackBar9: TTrackBar;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    StatusBar1: TStatusBar;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Chart2: TChart;
    LineSeries1: TLineSeries;
    LineSeries2: TLineSeries;
    LineSeries3: TLineSeries;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ComDataPacket1: TComDataPacket;
    ComDataPacket2: TComDataPacket;
    Label35: TLabel;
    Label37: TLabel;
    ComDataPacket3: TComDataPacket;
    ComDataPacket4: TComDataPacket;
    Button3: TButton;
    Button4: TButton;
    Timer1: TTimer;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    ComDataPacket5: TComDataPacket;
    ComDataPacket6: TComDataPacket;
    Label11: TLabel;
    ComDataPacket7: TComDataPacket;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure TrackBar8Change(Sender: TObject);
    procedure TrackBar9Change(Sender: TObject);
    procedure ComPort1RxChar(Sender: TObject; Count: Integer);
    procedure Button3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ComDataPacket1Packet(Sender: TObject; const Str: string);
    procedure ComDataPacket2Packet(Sender: TObject; const Str: string);
    procedure ComDataPacket3Packet(Sender: TObject; const Str: string);
    procedure ComDataPacket4Packet(Sender: TObject; const Str: string);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComDataPacket5Packet(Sender: TObject; const Str: string);
    procedure ComDataPacket6Packet(Sender: TObject; const Str: string);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ComDataPacket7Packet(Sender: TObject; const Str: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ReadBuffer: array[0..255] of char;
  accel_roll,gyro_roll,filter_roll:string;
  t_roll, t_pitch:integer;
  accel_pitch,gyro_pitch,filter_pitch:string;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
EnumComPorts(ComboBox1.Items);
ComboBox1.ItemIndex:= 0;
ComPort1.Port := ComboBox1.Items[ComboBox1.ItemIndex];
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
try
ComPort1.Open;
Label5.Caption:=ComboBox1.Text+', 115200';
Label5.Font.Color:= clGreen;
except
Label5.Font.Color:= clRed;
Label5.Caption:='��� ����������';
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ComPort1.Close;
Label5.Font.Color:= clRed;
Label5.Caption:='��� ����������';
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
ComPort1.WriteStr('RS'#10);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
ComPort1.WriteStr('PS'#10);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
ComPort1.WriteStr('RA'#10);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
ComPort1.WriteStr('PA'#10);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
ComPort1.WriteStr('RL'#10);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
ComPort1.WriteStr('PL'#10);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
ComPort1.Port := ComboBox1.Items[ComboBox1.ItemIndex];
end;

procedure TForm1.ComPort1RxChar(Sender: TObject; Count: Integer);
var str,ori_str:string;
Rotkl,Rerror,Rkor,Potkl,Perror,Pkor,Yotkl,Yerror,Ykor:string;
n,n1,n2,k,k1,k2:integer;
begin
{ComPort1.ReadStr(ori_str,Count);
Label33.Caption:=ori_str;

if (ori_str[1]='P') then
begin
str:= copy(ori_str,2,Length(ori_str)-1);
n:= pos('|',str);
accel_pitch:= copy(str,1,n-1);
Delete(str,1,n);
n1:= pos('|',str);
filter_pitch:= copy(str,1,n1-1);
Delete(str,1,n1);
Label17.Caption:=str;
Chart2.Series[0].AddXY(t_pitch, strtofloat(filter_pitch), '', clBlue);
Chart2.Series[1].AddXY(t_pitch, strtofloat(accel_pitch), '', clRed);
Chart2.Series[2].AddXY(t_pitch, strtofloat(trim(str)), '', clGreen);
if Series1.Count > 400 then begin
 Chart2.BottomAxis.AutomaticMinimum:=false;
 Chart2.BottomAxis.Minimum:=Chart1.BottomAxis.Minimum+1;
end;
t_pitch:=t_pitch+1;
end;
ori_str:= ''; }
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
FormatSettings.DecimalSeparator := '.';
end;

procedure TForm1.N2Click(Sender: TObject);
begin
form1.Close;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
StatusBar1.Panels.Items[0].text:=' '+TimeToStr(Time);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
Edit1.Text:=floattostr(TrackBar1.Position / 100);
ComPort1.WriteStr('RP'+Edit1.Text+''#10);
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
Edit2.Text:=floattostr(TrackBar2.Position / 1000);
ComPort1.WriteStr('RI'+Edit2.Text+''#10);
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
Edit3.Text:=floattostr(TrackBar3.Position / 1000);
ComPort1.WriteStr('RD'+Edit3.Text+''#10);
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
Edit4.Text:=floattostr(TrackBar4.Position / 100);
ComPort1.WriteStr('PP'+Edit4.Text+''#10);
end;

procedure TForm1.TrackBar5Change(Sender: TObject);
begin
Edit5.Text:=floattostr(TrackBar5.Position / 1000);
ComPort1.WriteStr('PI'+Edit5.Text+''#10);
end;

procedure TForm1.TrackBar6Change(Sender: TObject);
begin
Edit6.Text:=floattostr(TrackBar6.Position / 1000);
ComPort1.WriteStr('PD'+Edit6.Text+''#10);
end;

procedure TForm1.TrackBar7Change(Sender: TObject);
begin
Edit7.Text:=floattostr(TrackBar7.Position / 100);
ComPort1.WriteStr('YP'+Edit7.Text+''#13);
end;

procedure TForm1.TrackBar8Change(Sender: TObject);
begin
Edit8.Text:=floattostr(TrackBar8.Position / 100);
ComPort1.WriteStr('YI'+Edit8.Text+''#13);
end;

procedure TForm1.TrackBar9Change(Sender: TObject);
begin
Edit9.Text:=floattostr(TrackBar9.Position / 10000);
ComPort1.WriteStr('YD'+Edit9.Text+''#13);
end;

procedure TForm1.ComDataPacket1Packet(Sender: TObject; const Str: string);
var n,n1:integer;   str_tmp:string;
begin
if CheckBox1.Checked then
begin
  str_tmp:= copy(Str,0,Length(Str));
  n:= pos('|',str_tmp);
  accel_roll:= copy(str_tmp,1,n-1);
  Delete(str_tmp,1,n);
  n1:= pos('|',str_tmp);
  filter_roll:= copy(str_tmp,1,n1-1);
  Delete(str_tmp,1,n1);
  //Label34.Caption:=filter_roll;
  //Label36.Caption:=Str;
  Chart1.Series[0].AddXY(t_roll, strtofloat(filter_roll), '', clBlue);
  Chart1.Series[1].AddXY(t_roll, strtofloat(accel_roll), '', clRed);
  Chart1.Series[2].AddXY(t_roll, strtofloat(trim(str_tmp)), '', clGreen);
  if Series1.Count > 400 then begin
   Chart1.BottomAxis.AutomaticMinimum:=false;
   Chart1.BottomAxis.Minimum:=Chart1.BottomAxis.Minimum+1;
  end;
  t_roll:=t_roll+1;
end;
end;

procedure TForm1.ComDataPacket2Packet(Sender: TObject; const Str: string);
var n,n1:integer;    str_tmp:string;
begin
if CheckBox2.Checked then
begin
  str_tmp:= copy(Str,0,Length(Str));
  n:= pos('|',str_tmp);
  accel_pitch:= copy(str_tmp,1,n-1);
  Delete(str_tmp,1,n);
  n1:= pos('|',str_tmp);
  filter_pitch:= copy(str_tmp,1,n1-1);
  Delete(str_tmp,1,n1);
  //Label35.Caption:=trim(str_tmp);
  //Label37.Caption:=Str;
  Chart2.Series[0].AddXY(t_pitch, strtofloat(filter_pitch), '', clBlue);
  Chart2.Series[1].AddXY(t_pitch, strtofloat(accel_pitch), '', clRed);
  Chart2.Series[2].AddXY(t_pitch, strtofloat(trim(str_tmp)), '', clGreen);
  if Chart2.Series[0].Count > 400 then begin
     Chart2.BottomAxis.AutomaticMinimum:=false;
     Chart2.BottomAxis.Minimum:=Chart2.BottomAxis.Minimum+1;
  end;
  t_pitch:=t_pitch+1;
end;
end;

procedure TForm1.ComDataPacket3Packet(Sender: TObject; const Str: string);
var n,n1:integer;    str_tmp,filter_roll_2,error:string;
begin
  str_tmp:= copy(Str,0,Length(Str));
  n:= pos('|',str_tmp);
  error:= copy(str_tmp,1,n-1);
  Delete(str_tmp,1,n);
  n1:= pos('|',str_tmp);
  filter_roll_2:= copy(str_tmp,1,n1-1);
  Delete(str_tmp,1,n1);
 // Label35.Caption:=trim(str_tmp);
 // Label37.Caption:=Str;
 Label15.Caption:=filter_roll_2;
 Label16.Caption:=error;
 Label17.Caption:=trim(str_tmp);
{  Chart2.Series[0].AddXY(t_pitch, strtofloat(filter_pitch), '', clBlue);
  Chart2.Series[1].AddXY(t_pitch, strtofloat(accel_pitch), '', clRed);
  Chart2.Series[2].AddXY(t_pitch, strtofloat(trim(str_tmp)), '', clGreen);  }
end;

procedure TForm1.ComDataPacket4Packet(Sender: TObject; const Str: string);
var n,n1:integer;    str_tmp,filter_pitch_2,error:string;
begin
  str_tmp:= copy(Str,0,Length(Str));
  n:= pos('|',str_tmp);
  error:= copy(str_tmp,1,n-1);
  Delete(str_tmp,1,n);
  n1:= pos('|',str_tmp);
  filter_pitch_2:= copy(str_tmp,1,n1-1);
  Delete(str_tmp,1,n1);
 // Label35.Caption:=trim(str_tmp);
 // Label37.Caption:=Str;
 Label27.Caption:=filter_pitch_2;
 Label28.Caption:=error;
 Label29.Caption:=trim(str_tmp);
end;

procedure TForm1.ComDataPacket5Packet(Sender: TObject; const Str: string);
var n,n1:integer;    d1,d2,d3:string;
begin
  {d1:= copy(Str,0,Length(Str));
  n:= pos('|',d1);
  d3:= copy(d1,1,n-1);
  Delete(d1,1,n);
  n1:= pos('|',d1);
  d2:= copy(d1,1,n1-1);
  Delete(d1,1,n1);        }
 // Label35.Caption:=trim(str_tmp);
 // Label37.Caption:=Str;
 {Label27.Caption:=d2;
 Label28.Caption:=d3;
 Label29.Caption:=trim(d1); }
 //StatusBar1.Panels[2].Text:=Str;
end;

procedure TForm1.ComDataPacket6Packet(Sender: TObject; const Str: string);
var n,n1:integer;    tmp,kp,ki:string;
begin
  tmp:= copy(Str,0,Length(Str));
  n:= pos('|',tmp);
  kp:= copy(tmp,1,n-1);
  Delete(tmp,1,n);
  n1:= pos('|',tmp);
  ki:= copy(tmp,1,n1-1);
  Delete(tmp,1,n1);
  edit1.Text:=kp;
  edit2.Text:=ki;
  edit3.Text:=trim(tmp);

  TrackBar1.Position:=Trunc(strtofloat(kp)*100);
  TrackBar2.Position:=Trunc(strtofloat(ki)*1000);
  TrackBar3.Position:=Trunc(strtofloat(trim(tmp))*1000);
 // Label35.Caption:=trim(str_tmp);
 // Label37.Caption:=Str;
 {Label27.Caption:=d2;
 Label28.Caption:=d3;
 Label29.Caption:=trim(d1); }
 //StatusBar1.Panels[2].Text:=Str;
 StatusBar1.Panels[2].Text:=Str;
end;

procedure TForm1.ComDataPacket7Packet(Sender: TObject; const Str: string);
var n,n1:integer;    tmp,kp,ki:string;
begin
  tmp:= copy(Str,0,Length(Str));
  n:= pos('|',tmp);
  kp:= copy(tmp,1,n-1);
  Delete(tmp,1,n);
  n1:= pos('|',tmp);
  ki:= copy(tmp,1,n1-1);
  Delete(tmp,1,n1);
  edit4.Text:=kp;
  edit5.Text:=ki;
  edit6.Text:=trim(tmp);

  TrackBar4.Position:=Trunc(strtofloat(kp)*100);
  TrackBar5.Position:=Trunc(strtofloat(ki)*1000);
  TrackBar6.Position:=Trunc(strtofloat(trim(tmp))*1000);
 // Label35.Caption:=trim(str_tmp);
 // Label37.Caption:=Str;
 {Label27.Caption:=d2;
 Label28.Caption:=d3;
 Label29.Caption:=trim(d1); }
 //StatusBar1.Panels[2].Text:=Str;
 StatusBar1.Panels[2].Text:=Str;
end;

end.
