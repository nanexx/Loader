unit test_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmRegistration = class(TForm)
    btnRegister: TButton;
    btnExit: TButton;
    Label1: TLabel;
    eHardware: TEdit;
    eUserInfo: TEdit;
    eKey: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    lbUserInfo: TLabel;
    Bevel1: TBevel;
    btnDeleteKey: TButton;
    mKey: TMemo;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure btnDeleteKeyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegistration: TfrmRegistration;

implementation

uses enigma_ide;

{$R *.dfm}

procedure TfrmRegistration.btnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmRegistration.FormShow(Sender: TObject);
var
  name, key : AnsiString;
begin
  eHardware.Text := EP_RegHardwareID;
  if EP_RegLoadAndCheckKey then
  begin
    if EP_RegistrationLoadKeyA(name, key) then
    begin
      lbUserInfo.Caption := name;
      mKey.Text := key;
    end;
  end else
    ShowMessage('*************   Reminder window   *************'#13#10#13#10#13#10 +
                '   Register software to remove this message!   '#13#10 +
                '  For registration visit www.YourProduct.com   '#13#10#13#10);
end;

procedure TfrmRegistration.btnRegisterClick(Sender: TObject);
var
  name, key : AnsiString;
begin
  if EP_RegCheckAndSaveKey(PAnsiChar(AnsiString(eUserInfo.Text)), PAnsiChar(AnsiString(eKey.Text))) then
  begin
    if EP_RegistrationLoadKeyA(name, key) then
    begin
      lbUserInfo.Caption := name;
      mKey.Text := key;
      ShowMessage('Thanks for registration');
    end;
  end else ShowMessage('Invalid key');
end;

procedure TfrmRegistration.btnDeleteKeyClick(Sender: TObject);
begin
  EP_RegDeleteKey;
end;

end.
