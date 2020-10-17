unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonClose: TButton;
    ButtonUP: TButton;
    ButtonLEFT: TButton;
    ButtonRIGHT: TButton;
    ButtonDOWN: TButton;
    ButtonStart: TButton;
    L11: TLabel;
    L32: TLabel;
    L33: TLabel;
    L34: TLabel;
    L41: TLabel;
    L42: TLabel;
    L43: TLabel;
    L44: TLabel;
    L12: TLabel;
    L13: TLabel;
    L14: TLabel;
    L21: TLabel;
    L22: TLabel;
    L23: TLabel;
    L24: TLabel;
    L31: TLabel;
    LResult: TLabel;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonDOWNClick(Sender: TObject);
    procedure ButtonLEFTClick(Sender: TObject);
    procedure ButtonRIGHTClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonUPClick(Sender: TObject);
  private
    cell:array[1..4,1..4] of integer;
  public
    procedure invdLabel;
    procedure gameOver(isWin:boolean);
    function isGameOver:boolean;
    procedure genNewNum;
    procedure sUp;
    procedure sDown;
    procedure sLeft;
    procedure sRight;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  randomize;
  fillchar(cell,sizeof(cell),0);
  cell[random(4)+1,random(4)+1]:=2;
  ButtonUP.Enabled:=true;
  ButtonLEFT.Enabled:=true;
  ButtonRIGHT.Enabled:=true;
  ButtonDOWN.Enabled:=true;
  invdLabel;
  LResult.Caption:='';
end;

procedure TForm1.ButtonDOWNClick(Sender: TObject);
begin
  sDown;
end;

procedure TForm1.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ButtonLEFTClick(Sender: TObject);
begin
  sLeft;
end;

procedure TForm1.ButtonRIGHTClick(Sender: TObject);
begin
  sRight;
end;

procedure TForm1.ButtonUPClick(Sender: TObject);
begin
  sUp;
end;

procedure TForm1.invdLabel;
begin
  if cell[1,1]<>0 then
    L11.Caption:=IntToStr(cell[1,1])
  else
    L11.Caption:='';
  if cell[1,2]<>0 then
    L12.Caption:=IntToStr(cell[1,2])
  else
    L12.Caption:='';
  if cell[1,3]<>0 then
    L13.Caption:=IntToStr(cell[1,3])
  else
    L13.Caption:='';
  if cell[1,4]<>0 then
    L14.Caption:=IntToStr(cell[1,4])
  else
    L14.Caption:='';
  if cell[2,1]<>0 then
    L21.Caption:=IntToStr(cell[2,1])
  else
    L21.Caption:='';
  if cell[2,2]<>0 then
    L22.Caption:=IntToStr(cell[2,2])
  else
    L22.Caption:='';
  if cell[2,3]<>0 then
    L23.Caption:=IntToStr(cell[2,3])
  else
    L23.Caption:='';
  if cell[2,4]<>0 then
    L24.Caption:=IntToStr(cell[2,4])
  else
    L24.Caption:='';
  if cell[3,1]<>0 then
    L31.Caption:=IntToStr(cell[3,1])
  else
    L31.Caption:='';
  if cell[3,2]<>0 then
    L32.Caption:=IntToStr(cell[3,2])
  else
    L32.Caption:='';
  if cell[3,3]<>0 then
    L33.Caption:=IntToStr(cell[3,3])
  else
    L33.Caption:='';
  if cell[3,4]<>0 then
    L34.Caption:=IntToStr(cell[3,4])
  else
    L34.Caption:='';
  if cell[4,1]<>0 then
    L41.Caption:=IntToStr(cell[4,1])
  else
    L41.Caption:='';
  if cell[4,2]<>0 then
    L42.Caption:=IntToStr(cell[4,2])
  else
    L42.Caption:='';
  if cell[4,3]<>0 then
    L43.Caption:=IntToStr(cell[4,3])
  else
    L43.Caption:='';
  if cell[4,4]<>0 then
    L44.Caption:=IntToStr(cell[4,4])
  else
    L44.Caption:='';
end;

procedure TForm1.gameOver(isWin: boolean);
begin
  fillchar(cell,sizeof(cell),0);
  ButtonUP.Enabled:=false;
  ButtonLEFT.Enabled:=false;
  ButtonRIGHT.Enabled:=false;
  ButtonDOWN.Enabled:=false;
  invdLabel;
  if isWin then
    LResult.Caption:='Win!'
  else
    LResult.Caption:='Lose!'
end;

function TForm1.isGameOver: boolean;
var
  flag:boolean;
  i,j:integer;
begin
  flag:=true;
  for i:=1 to 4 do
    for j:=1 to 4 do
      if cell[i,j]=0 then flag:=false;
  isGameOver:=flag;
end;

procedure TForm1.genNewNum;
var
  i,j:integer;
begin
  randomize;
  repeat
    i:=random(4)+1;
    j:=random(4)+1;
  until cell[i,j]=0;
  cell[i,j]:=2;
end;

procedure TForm1.sUp;
var
  i,j,k:integer;
  flag:boolean;
begin
  flag:=true;
  for i:=1 to 4 do begin
    for j:=1 to 4 do
      for k:=1 to 3 do
        if (cell[k,i]=0) {and (cell[k+1,i]<>0)} then begin
          cell[k,i]:=cell[k+1,i];
          cell[k+1,i]:=0;
          if cell[k,i]<>cell[k+1,i] then flag:=false;
        end
        else if (cell[k,i]=cell[k+1,i]) and (cell[k,i] mod 2=0) then begin
          cell[k,i]:=cell[k,i] shl 1+1;
          cell[k+1,i]:=0;
          flag:=false;
        end;
    for j:=1 to 4 do begin
      if cell[j,i] mod 2 <> 0 then dec(cell[j,i]);
      if cell[j,i]>=2048 then begin
        gameover(true);
        exit;
      end;
    end;
  end;
  if isGameOver then begin
    gameover(false);
    exit;
  end;
  if flag then exit;
  genNewNum;
  invdLabel;
end;

procedure TForm1.sDown;
var
  i,j,k:integer;
  flag:boolean;
begin
  flag:=true;
  for i:=1 to 4 do begin
    for j:=1 to 4 do
      for k:=4 downto 2 do
        if (cell[k,i]=0) {and (cell[k-1,i]<>0])} then begin
          cell[k,i]:=cell[k-1,i];
          cell[k-1,i]:=0;
          if cell[k,i]<>cell[k-1,i] then flag:=false;
        end
        else if (cell[k,i]=cell[k-1,i]) and (cell[k,i] mod 2 =0) then begin
          cell[k,i]:=cell[k,i] shl 1+1;
          cell[k-1,i]:=0;
          flag:=false;
        end;
    for j:=1 to 4 do begin
      if cell[j,i] mod 2 <> 0 then dec(cell[j,i]);
      if cell[j,i]>=2048 then begin
        gameover(true);
        exit;
      end;
    end;
  end;
  if isGameOver then begin
    gameover(false);
    exit;
  end;
  if flag then exit;
  genNewNum;
  invdLabel;
end;

procedure TForm1.sLeft;
var
  i,j,k:integer;
  flag:boolean;
begin
  flag:=true;
  for i:=1 to 4 do begin
    for j:=1 to 4 do
      for k:=1 to 3 do
        if (cell[i,k]=0) {and (cell[i,k+1]<>0)} then begin
          cell[i,k]:=cell[i,k+1];
          cell[i,k+1]:=0;
          if cell[i,k]<>cell[i,k+1] then flag:=false;
        end
        else if (cell[i,k]=cell[i,k+1]) and (cell[i,k] mod 2=0) then begin
          cell[i,k]:=cell[i,k] shl 1+1;
          cell[i,k+1]:=0;
          flag:=false;
        end;
    for j:=1 to 4 do begin
      if cell[i,j] mod 2 <> 0 then dec(cell[i,j]);
      if cell[i,j]>=2048 then begin
        gameover(true);
        exit;
      end;
    end;
  end;
  if isGameOver then begin
    gameover(false);
    exit;
  end;
  if flag then exit;
  genNewNum;
  invdLabel;
end;

procedure TForm1.sRight;
var
  i,j,k:integer;
  flag:boolean;
begin
  flag:=true;
  for i:=1 to 4 do begin
    for j:=1 to 4 do
      for k:=4 downto 2 do
        if (cell[i,k]=0) {and (cell[i,k-1]<>0)} then begin
          cell[i,k]:=cell[i,k-1];
          cell[i,k-1]:=0;
          if cell[i,k]<>cell[i,k-1] then flag:=false;
        end
        else if (cell[i,k]=cell[i,k-1]) and (cell[i,k] mod 2=0) then begin
          cell[i,k]:=cell[i,k] shl 1+1;
          cell[i,k-1]:=0;
          flag:=false;
        end;
    for j:=1 to 4 do begin
      if cell[i,j] mod 2 <> 0 then dec(cell[i,j]);
      if cell[i,j]>=2048 then begin
        gameover(true);
        exit;
      end;
    end;
  end;
  if isGameOver then begin
    gameover(false);
    exit;
  end;
  if flag then exit;
  genNewNum;
  invdLabel;
end;

end.

