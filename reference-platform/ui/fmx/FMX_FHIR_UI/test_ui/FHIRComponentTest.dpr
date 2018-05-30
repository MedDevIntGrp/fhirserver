program FHIRComponentTest;

uses
  System.StartUpCopy,
  FMX.Forms,
  FHIR.Base.Objects in '..\..\..\..\base\FHIR.Base.Objects.pas',
  FHIR.R4.Resources in '..\..\..\..\R4\FHIR.R4.Resources.pas',
  FHIR.Tools.Session in '..\..\..\..\tools\FHIR.Tools.Session.pas',
  FHIR.Tools.Indexing in '..\..\..\..\tools\FHIR.Tools.Indexing.pas',
  FHIR.Tools.Security in '..\..\..\..\tools\FHIR.Tools.Security.pas',
  FHIR.Tools.Parser in '..\..\..\..\tools\FHIR.Tools.Parser.pas',
  FHIR.Tools.XhtmlComp in '..\..\..\..\tools\FHIR.Tools.XhtmlComp.pas',
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
