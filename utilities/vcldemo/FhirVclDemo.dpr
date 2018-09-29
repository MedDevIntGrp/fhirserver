program FhirVclDemo;

uses
  FastMM4 in '..\..\dependencies\FMM\FastMM4.pas' {Vcl.Forms},
  Vcl.Forms,
  MainApplicationWindow in '..\MainApplicationWindow.pas' {MainWindowForm},
  FastMM4Messages in '..\..\dependencies\FMM\FastMM4Messages.pas',
  FHIR.Support.Utilities in '..\..\library\support\FHIR.Support.Utilities.pas',
  FHIR.Support.Base in '..\..\library\support\FHIR.Support.Base.pas',
  FHIR.Support.Stream in '..\..\library\support\FHIR.Support.Stream.pas',
  FHIR.Support.Collections in '..\..\library\support\FHIR.Support.Collections.pas',
  FHIR.Base.Objects in '..\..\library\base\FHIR.Base.Objects.pas',
  FHIR.R2.Utilities in '..\..\library\r2\FHIR.R2.Utilities.pas',
  FHIR.Web.Parsers in '..\..\library\web\FHIR.Web.Parsers.pas',
  FHIR.Support.Json in '..\..\library\support\FHIR.Support.Json.pas',
  FHIR.Web.Fetcher in '..\..\library\web\FHIR.Web.Fetcher.pas',
  FHIR.R2.Context in '..\..\library\r2\FHIR.R2.Context.pas',
  FHIR.R2.Types in '..\..\library\r2\FHIR.R2.Types.pas',
  FHIR.R2.Resources in '..\..\library\r2\FHIR.R2.Resources.pas',
  FHIR.Base.Scim in '..\..\library\base\FHIR.Base.Scim.pas',
  FHIR.Support.MXml in '..\..\library\support\FHIR.Support.MXml.pas',
  FHIR.Tools.Indexing in '..\..\library\tools\FHIR.Tools.Indexing.pas',
  FHIR.R2.Constants in '..\..\library\r2\FHIR.R2.Constants.pas',
  FHIR.R2.Tags in '..\..\library\r2\FHIR.R2.Tags.pas',
  FHIR.Base.Lang in '..\..\library\base\FHIR.Base.Lang.pas',
  FHIR.Base.Xhtml in '..\..\library\base\FHIR.Base.Xhtml.pas',
  FHIR.Version.Parser in '..\..\library\version\FHIR.Version.Parser.pas',
  FHIR.Base.Parser in '..\..\library\base\FHIR.Base.Parser.pas',
  FHIR.Support.Turtle in '..\..\library\support\FHIR.Support.Turtle.pas',
  FHIR.R2.Xml in '..\..\library\r2\FHIR.R2.Xml.pas',
  FHIR.R2.Json in '..\..\library\r2\FHIR.R2.Json.pas',
  FHIR.R2.ElementModel in '..\..\library\r2\FHIR.R2.ElementModel.pas',
  FHIR.R2.Profiles in '..\..\library\r2\FHIR.R2.Profiles.pas',
  FHIR.Support.Threads in '..\..\library\support\FHIR.Support.Threads.pas',
  FHIR.R2.PathEngine in '..\..\library\r2\FHIR.R2.PathEngine.pas',
  FHIR.Version.Client in '..\..\library\version\FHIR.Version.Client.pas',
  FHIR.Web.WinInet in '..\..\library\web\FHIR.Web.WinInet.pas',
  FHIR.CdsHooks.Utilities in '..\..\library\cdshooks\FHIR.CdsHooks.Utilities.pas',
  MarkdownProcessor in '..\..\..\markdown\source\MarkdownProcessor.pas',
  MarkdownDaringFireball in '..\..\..\markdown\source\MarkdownDaringFireball.pas',
  MarkdownCommonMark in '..\..\..\markdown\source\MarkdownCommonMark.pas',
  FHIR.Support.Shell in '..\..\library\support\FHIR.Support.Shell.pas',
  FHIR.Ucum.IFace in '..\..\library\ucum\FHIR.Ucum.IFace.pas',
  FHIR.R2.PathNode in '..\..\library\r2\FHIR.R2.PathNode.pas',
  FHIR.R2.Base in '..\..\library\r2\FHIR.R2.Base.pas',
  FHIR.R2.Parser in '..\..\library\r2\FHIR.R2.Parser.pas',
  FHIR.R2.ParserBase in '..\..\library\r2\FHIR.R2.ParserBase.pas',
  FHIR.Client.Base in '..\..\library\client\FHIR.Client.Base.pas',
  FHIR.Client.HTTP in '..\..\library\client\FHIR.Client.HTTP.pas',
  FHIR.Client.Threaded in '..\..\library\client\FHIR.Client.Threaded.pas',
  FHIR.R2.Client in '..\..\library\r2\FHIR.R2.Client.pas',
  FHIR.Support.Xml in '..\..\library\support\FHIR.Support.Xml.pas',
  FHIR.Support.Certs in '..\..\library\support\FHIR.Support.Certs.pas',
  FHIR.Web.GraphQL in '..\..\library\web\FHIR.Web.GraphQL.pas',
  FHIR.Base.Factory in '..\..\library\base\FHIR.Base.Factory.pas',
  FHIR.Base.Validator in '..\..\library\base\FHIR.Base.Validator.pas',
  FHIR.Base.Common in '..\..\library\base\FHIR.Base.Common.pas',
  FHIR.Base.Narrative in '..\..\library\base\FHIR.Base.Narrative.pas',
  FHIR.Base.PathEngine in '..\..\library\base\FHIR.Base.PathEngine.pas',
  FHIR.R2.Common in '..\..\library\r2\FHIR.R2.Common.pas',
  FHIR.Support.Signatures in '..\..\library\support\FHIR.Support.Signatures.pas',
  fhir.support.fpc in '..\..\library\support\fhir.support.fpc.pas',
  FHIR.Base.Utilities in '..\..\library\base\FHIR.Base.Utilities.pas',
  FHIR.Smart.Utilities in '..\..\library\smart\FHIR.Smart.Utilities.pas',
  FHIR.Smart.Login in '..\..\library\smart\FHIR.Smart.Login.pas',
  FHIR.Smart.LoginVCL in '..\..\library\smart\FHIR.Smart.LoginVCL.pas' {SmartOnFhirLoginForm},
  FHIR.R2.Operations in '..\..\library\r2\FHIR.R2.Operations.pas',
  FHIR.R2.OpBase in '..\..\library\r2\FHIR.R2.OpBase.pas',
  FHIR.Support.Osx in '..\..\library\support\FHIR.Support.Osx.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainWindowForm, MainWindowForm);
  Application.CreateForm(TSmartOnFhirLoginForm, SmartOnFhirLoginForm);
  Application.CreateForm(TSmartOnFhirLoginForm, SmartOnFhirLoginForm);
  Application.CreateForm(TSmartOnFhirLoginForm, SmartOnFhirLoginForm);
  Application.Run;
end.