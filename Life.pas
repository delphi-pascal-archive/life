unit Life;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    Hor: TScrollBar;
    Vert: TScrollBar;
    OD: TOpenDialog;
    GroupBox1: TGroupBox;
    LT: TLabel;
    SW: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    NN: TEdit;
    Res: TButton;
    SPD: TEdit;
    Button5: TButton;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click2(Sender: TObject);
    procedure SWClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ResClick(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure VertScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure HorScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  P: array [-1..1000, -1..1000] of Boolean;
  CX,CY,N,L,Zoom,IW,IH: Integer;

implementation

procedure Render;
var X,Y,BX,BY: Integer;
begin
 Form1.Image1.Canvas.Brush.Color:=clWhite;
 Form1.Image1.Canvas.FillRect(Form1.Image1.ClientRect);
 BX:=CX-((IW div 2) div Zoom);
 BY:=CY-((IH div 2) div Zoom);
 Form1.Image1.Canvas.Pen.Color:=clRed;
 Form1.Image1.Canvas.Rectangle((-BX)*Zoom,(-BY)*Zoom,(-BX+N)*Zoom,(-BY+N)*Zoom);
 Form1.Image1.Canvas.Brush.Color:=clBlack;
 Form1.Image1.Canvas.Pen.Color:=clBlack;
 for X:=0 to (IW div Zoom)-1 do
  for Y:=0 to (IH div Zoom)-1 do
   if P[X+BX,Y+BY] then begin
    if Zoom>1 then Form1.Image1.Canvas.Rectangle(X*Zoom,Y*Zoom,(X+1)*Zoom,(Y+1)*Zoom)
     else Form1.Image1.Canvas.Pixels[X,Y]:=clBlack;
   end;
 Form1.Image1.Canvas.Pen.Color:=clSilver;
 if Zoom>=3 then begin
  for X:=0 to (IW div Zoom) do begin
   Form1.Image1.Canvas.MoveTo(X*Zoom,0);
   Form1.Image1.Canvas.LineTo(X*Zoom,IH);
  end;
  for Y:=0 to (IH div Zoom) do begin
   Form1.Image1.Canvas.MoveTo(0,Y*Zoom);
   Form1.Image1.Canvas.LineTo(IW,Y*Zoom);
  end;
 end;
end;

function Cap(I, Min, Max: Integer): Integer;
begin
 if I<Min then Result:=Min
  else if I>Max then Result:=Max
   else Result:=I;
end;

function GetInf(X,Y: Integer): Boolean;
var TX,TY: Integer;
begin
 //Result:=P[((X-1) mod N)+1, ((Y-1) mod N)+1];
 if Form1.CheckBox1.Checked then begin
  TX:=X;
  if X<0 then TX:=N+X;
  if X>=N then TX:=X-N;
   TY:=Y;
  if Y<0 then TY:=N+Y;
  if Y>=N then TY:=Y-N;
 end else begin
  TX:=Cap(X,-1,N);
  TY:=Cap(Y,-1,N);
 end;
 Result:=P[TX,TY];
end;

function Num(X,Y: Integer): Integer;
var T,X1,Y1: Integer;
begin
 T:=0;
 if GetInf(X-1,Y) then T:=T+1;
 if GetInf(X+1,Y) then T:=T+1;
 if GetInf(X-1,Y-1) then T:=T+1;
 if GetInf(X-1,Y+1) then T:=T+1;
 if GetInf(X+1,Y-1) then T:=T+1;
 if GetInf(X+1,Y+1) then T:=T+1;
 if GetInf(X,Y+1) then T:=T+1;
 if GetInf(X,Y-1) then T:=T+1;
 Result:=T;
end;

procedure Turn;
var X,Y: Integer;
T: array [0..1000, 0..1000] of Boolean;
begin
 for X:=0 to N-1 do
  for Y:=0 to N-1 do begin
  // if (P[X,Y]) or (Num(X,Y)=3) then begin
    if P[X,Y] then T[X,Y]:=True else T[X,Y]:=False;
    if (Num(X,Y)=3) then T[X,Y]:=True;
    if (Num(X,Y)<2) or (Num(X,Y)>3) then T[X,Y]:=False;
  // end;
  end;
 for X:=0 to N-1 do
  for Y:=0 to N-1 do P[X,Y]:=T[X,Y];
end;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var X,Y: Integer;
begin
 IW:=Image1.Width;
 IH:=Image1.Height;
 Zoom:=4;
 L:=0;
 LT.Caption:=Format('Lifetime: %d',[L]);
 N:=StrToInt(NN.Text);
 Vert.Max:=N-100;
 Hor.Max:=N-100;
 Vert.Position:=(N div 2)-(IW div (Zoom*2));
 Hor.Position:=(N div 2)-(IH div (Zoom*2));
 Timer1.Enabled:=False;
 for X:=0 to N do
  for Y:=0 to N do P[X,Y]:=False;
 CX:=N div 2;
 CY:=N div 2;
 X:=Vert.Max div 2;
 Y:=Hor.Max div 2;
 VertScroll(Self,scPosition,X);
 HorScroll(Self,scPosition,Y);
 Render;
end;

procedure TForm1.Button1Click2(Sender: TObject);
begin
 L:=L+1;
 LT.Caption:=Format('Lifetime: %d',[L]);
 Turn;
 Render;
end;

procedure TForm1.SWClick(Sender: TObject);
begin
 Timer1.Enabled:=not Timer1.Enabled;
end;

procedure TForm1.Image1Click(Sender: TObject);
var X,Y,W,H: Integer;
begin
 W:=Width-ClientWidth;
 H:=Height-ClientHeight;
 X:=((Mouse.CursorPos.X-Form1.Left-Image1.Left) div Zoom)-1;
 Y:=((Mouse.CursorPos.Y-Form1.Top-Image1.Top-H+(Zoom+4)) div Zoom)-1;
 P[X+(CX-((IW div 2) div Zoom)),Y+(CY-((IH div 2) div Zoom))]:=
 not P[X+(CX-((IW div 2) div Zoom)),Y+(CY-((IH div 2) div Zoom))];
 Render;
end;

procedure TForm1.ResClick(Sender: TObject);
begin
 FormCreate(Self);
 FormResize(Self);
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if ssLeft in Shift then P[X div 4, Y div 4]:=True;
 if ssRight in Shift then P[X div 4, Y div 4]:=False;
 Render;
end;

procedure TForm1.VertScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
 CY:=ScrollPos+((IH div 2) div Zoom);
 Render;
end;

procedure TForm1.HorScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
 CX:=ScrollPos+((IW div 2) div Zoom);
 Render;
end;

procedure TForm1.Button1Click(Sender: TObject);
var Max, X, Y, BX, BY, YY: Integer;
S: String;
T: array [1..1000, 1..1000] of Boolean;
F: TextFile;
begin
 Timer1.Enabled:=False;
 if OD.Execute then begin
  AssignFile(F,OD.FileName);
  ReSet(F);
  ReadLn(F);
  for X:=1 to 1000 do
   for Y:=1 to 1000 do T[X,Y]:=False;
  Y:=0;
  Max:=0;
  while EoF(F)=False do begin
   Y:=Y+1;
   ReadLn(F,S);
   for X:=1 to Length(S) do
    if (S[X]='*') or (S[X]='O') then T[X,Y]:=True;
   if Length(S)>Max then Max:=Length(S);
  end;
  BX:=(N div 2)-(Max div 2);
  BY:=(N div 2)-(Y div 2);
  YY:=Y;
  for X:=1 to Max do
   for Y:=1 to YY do
    P[BX+X,BY+Y]:=T[X,Y];
  CloseFile(F);
  Render;
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var X,Y: Integer;
begin
 FormCreate(Self);
 for X:=0 to N do
  for Y:=0 to N do
   if Random(5)=0 then P[X,Y]:=True;
 Render;
end;

procedure TForm1.Button3Click(Sender: TObject);
var U,V,X,Y: Integer;
begin
 Zoom:=Zoom+1;
 U:=N-(IH div Zoom);
 if U<=0 then
  Vert.Max:=1
 else
  Vert.Max:=U;
 V:=N-(IW div Zoom);
 if V<=0 then
  Hor.Max:=1
 else
  Hor.Max:=V;
 X:=Vert.Max div 2;
 Y:=Hor.Max div 2;
 Vert.Position:=X;
 Hor.Position:=X;
 VertScroll(Self,scPosition,X);
 HorScroll(Self,scPosition,Y);
 Render;
end;

procedure TForm1.Button4Click(Sender: TObject);
var U,V,X,Y: Integer;
begin
 Zoom:=Zoom-1;
 if Zoom<2 then Zoom:=2;
 U:=N-(IH div Zoom);
 if U<=0 then
  Vert.Max:=1
 else
  Vert.Max:=U;
 V:=N-(IW div Zoom);
 if V<=0 then
  Hor.Max:=1
 else
  Hor.Max:=V;
 X:=Vert.Max div 2;
 Y:=Hor.Max div 2;
 Vert.Position:=X;
 Hor.Position:=X;
 VertScroll(Self,scPosition,X);
 HorScroll(Self,scPosition,Y);
 Render;
end;

procedure TForm1.FormResize(Sender: TObject);
var U,V,X,Y: Integer;
begin
 Image1.Width:=ClientWidth-GroupBox1.Width-Vert.Width-16;
 Image1.Height:=ClientHeight-Hor.Height-16;
 Hor.Width:=Image1.Width-8;
 Vert.Height:=Image1.Height-8;
 Hor.Top:=Image1.Height+8;
 Vert.Left:=Image1.Width+8;
 GroupBox1.Left:=Vert.Left+8+Vert.Width;
 Image1.Picture.Bitmap.Width:=Image1.Width;
 Image1.Picture.Bitmap.Height:=Image1.Height;
 IW:=Image1.Width;
 IH:=Image1.Height;
 U:=N-(IH div Zoom);
 if U<=0 then
  Vert.Max:=1
 else
  Vert.Max:=U;
 V:=N-(IW div Zoom);
 if V<=0 then
  Hor.Max:=1
 else
  Hor.Max:=V;
 X:=Vert.Max div 2;
 Y:=Hor.Max div 2;
 Vert.Position:=X;
 Hor.Position:=X;
 VertScroll(Self,scPosition,X);
 HorScroll(Self,scPosition,Y);
 Render;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 Timer1.Interval:=StrToInt(SPD.Text);
end;

end.
