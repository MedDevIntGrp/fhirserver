program FHIRTransformer;

uses
  FastMM4 in '..\dependencies\FMM\FastMM4.pas',
  FastMM4Messages in '..\dependencies\FMM\FastMM4Messages.pas',
  Vcl.Forms,
  FHIR.Base.Common in '..\library\base\FHIR.Base.Common.pas',
  FHIR.Base.Factory in '..\library\base\FHIR.Base.Factory.pas',
  FHIR.Base.Lang in '..\library\base\FHIR.Base.Lang.pas',
  FHIR.Base.Narrative in '..\library\base\FHIR.Base.Narrative.pas',
  FHIR.Base.Objects in '..\library\base\FHIR.Base.Objects.pas',
  FHIR.Base.Parser in '..\library\base\FHIR.Base.Parser.pas',
  FHIR.Base.PathEngine in '..\library\base\FHIR.Base.PathEngine.pas',
  FHIR.Base.Utilities in '..\library\base\FHIR.Base.Utilities.pas',
  FHIR.Base.Validator in '..\library\base\FHIR.Base.Validator.pas',
  FHIR.Base.Xhtml in '..\library\base\FHIR.Base.Xhtml.pas',
  FHIR.Cache.PackageBrowser in '..\library\cache\FHIR.Cache.PackageBrowser.pas' {PackageFinderForm},
  FHIR.Cache.PackageManager in '..\library\cache\FHIR.Cache.PackageManager.pas',
  FHIR.Cache.PackageManagerDialog in '..\library\cache\FHIR.Cache.PackageManagerDialog.pas' {PackageCacheForm},
  FHIR.Cda.Base in '..\library\cda\FHIR.Cda.Base.pas',
  FHIR.Cda.Documents in '..\library\cda\FHIR.Cda.Documents.pas',
  FHIR.Cda.Objects in '..\library\cda\FHIR.Cda.Objects.pas',
  FHIR.Cda.Parser in '..\library\cda\FHIR.Cda.Parser.pas',
  FHIR.Cda.Scint in '..\library\cda\FHIR.Cda.Scint.pas',
  FHIR.Cda.Types in '..\library\cda\FHIR.Cda.Types.pas',
  FHIR.Cda.Writer in '..\library\cda\FHIR.Cda.Writer.pas',
  FHIR.Client.Base in '..\library\client\FHIR.Client.Base.pas',
  FHIR.Client.HTTP in '..\library\client\FHIR.Client.HTTP.pas',
  FHIR.Client.Javascript in '..\library\client\FHIR.Client.Javascript.pas',
  FHIR.Client.Threaded in '..\library\client\FHIR.Client.Threaded.pas',
  FHIR.Javascript in '..\library\javascript\FHIR.Javascript.pas',
  FHIR.Javascript.Base in '..\library\javascript\FHIR.Javascript.Base.pas',
  FHIR.Javascript.Chakra in '..\library\javascript\FHIR.Javascript.Chakra.pas',
  FHIR.R4.AuthMap in '..\library\r4\FHIR.R4.AuthMap.pas',
  FHIR.R4.Base in '..\library\r4\FHIR.R4.Base.pas',
  FHIR.R4.Client in '..\library\r4\FHIR.R4.Client.pas',
  FHIR.R4.Common in '..\library\r4\FHIR.R4.Common.pas',
  FHIR.R4.Constants in '..\library\r4\FHIR.R4.Constants.pas',
  FHIR.R4.Context in '..\library\r4\FHIR.R4.Context.pas',
  FHIR.R4.ElementModel in '..\library\r4\FHIR.R4.ElementModel.pas',
  FHIR.R4.Factory in '..\library\r4\FHIR.R4.Factory.pas',
  FHIR.R4.Json in '..\library\r4\FHIR.R4.Json.pas',
  FHIR.R4.MapUtilities in '..\library\r4\FHIR.R4.MapUtilities.pas',
  FHIR.R4.Narrative in '..\library\r4\FHIR.R4.Narrative.pas',
  FHIR.R4.OpBase in '..\library\r4\FHIR.R4.OpBase.pas',
  FHIR.R4.Operations in '..\library\r4\FHIR.R4.Operations.pas',
  FHIR.R4.Parser in '..\library\r4\FHIR.R4.Parser.pas',
  FHIR.R4.ParserBase in '..\library\r4\FHIR.R4.ParserBase.pas',
  FHIR.R4.PathEngine in '..\library\r4\FHIR.R4.PathEngine.pas',
  FHIR.R4.PathNode in '..\library\r4\FHIR.R4.PathNode.pas',
  FHIR.R4.Profiles in '..\library\r4\FHIR.R4.Profiles.pas',
  FHIR.R4.Resources in '..\library\r4\FHIR.R4.Resources.pas',
  FHIR.R4.Turtle in '..\library\r4\FHIR.R4.Turtle.pas',
  FHIR.R4.Types in '..\library\r4\FHIR.R4.Types.pas',
  FHIR.R4.Utilities in '..\library\r4\FHIR.R4.Utilities.pas',
  FHIR.R4.Validator in '..\library\r4\FHIR.R4.Validator.pas',
  FHIR.R4.Xml in '..\library\r4\FHIR.R4.Xml.pas',
  FHIR.Smart.Utilities in '..\library\smart\FHIR.Smart.Utilities.pas',
  FHIR.Support.Base in '..\library\support\FHIR.Support.Base.pas',
  FHIR.Support.Certs in '..\library\support\FHIR.Support.Certs.pas',
  FHIR.Support.Collections in '..\library\support\FHIR.Support.Collections.pas',
  FHIR.Support.Comparisons in '..\library\support\FHIR.Support.Comparisons.pas',
  FHIR.Support.Fpc in '..\library\support\FHIR.Support.Fpc.pas',
  FHIR.Support.Graphics in '..\library\support\FHIR.Support.Graphics.pas',
  FHIR.Support.Html in '..\library\support\FHIR.Support.Html.pas',
  FHIR.Support.Javascript in '..\library\support\FHIR.Support.Javascript.pas',
  FHIR.Support.Json in '..\library\support\FHIR.Support.Json.pas',
  FHIR.Support.Lang in '..\library\support\FHIR.Support.Lang.pas',
  FHIR.Support.Logging in '..\library\support\FHIR.Support.Logging.pas',
  FHIR.Support.MXml in '..\library\support\FHIR.Support.MXml.pas',
  FHIR.Support.Ole in '..\library\support\FHIR.Support.Ole.pas',
  FHIR.Support.Osx in '..\library\support\FHIR.Support.Osx.pas',
  FHIR.Support.Printing in '..\library\support\FHIR.Support.Printing.pas',
  FHIR.Support.Shell in '..\library\support\FHIR.Support.Shell.pas',
  FHIR.Support.Signatures in '..\library\support\FHIR.Support.Signatures.pas',
  FHIR.Support.Stream in '..\library\support\FHIR.Support.Stream.pas',
  FHIR.Support.Threads in '..\library\support\FHIR.Support.Threads.pas',
  FHIR.Support.Turtle in '..\library\support\FHIR.Support.Turtle.pas',
  FHIR.Support.Utilities in '..\library\support\FHIR.Support.Utilities.pas',
  FHIR.Support.Xml in '..\library\support\FHIR.Support.Xml.pas',
  FHIR.Transformer.Context in '..\npp\FHIR.Transformer.Context.pas',
  FHIR.Transformer.Engine in 'FHIR.Transformer.Engine.pas',
  FHIR.Transformer.IDE in 'FHIR.Transformer.IDE.pas' {TransformerForm},
  FHIR.Transformer.Utilities in 'FHIR.Transformer.Utilities.pas',
  FHIR.Transformer.Workspace in 'FHIR.Transformer.Workspace.pas',
  FHIR.Ucum.IFace in '..\library\ucum\FHIR.Ucum.IFace.pas',
  FHIR.Ui.GdiPlus in '..\library\ui\FHIR.Ui.GdiPlus.pas',
  FHIR.Ui.ListSelector in '..\library\ui\FHIR.Ui.ListSelector.pas' {ListSelectorForm},
  FHIR.Web.Fetcher in '..\library\web\FHIR.Web.Fetcher.pas',
  FHIR.Web.Parsers in '..\library\web\FHIR.Web.Parsers.pas',
  FHIR.Web.WinInet in '..\library\web\FHIR.Web.WinInet.pas',
  GraphicColor in '..\dependencies\ui\GraphicColor.pas',
  GraphicCompression in '..\dependencies\ui\GraphicCompression.pas',
  GraphicEx in '..\dependencies\ui\GraphicEx.pas',
  GraphicStrings in '..\dependencies\ui\GraphicStrings.pas',
  JPG in '..\dependencies\ui\JPG.pas',
  MZLib in '..\dependencies\ui\MZLib.pas',
  ScintEdit in '..\dependencies\ui\ScintEdit.pas',
  ScintInt in '..\dependencies\ui\ScintInt.pas',
  VTAccessibility in '..\dependencies\treeview\Source\VTAccessibility.pas',
  VTAccessibilityFactory in '..\dependencies\treeview\Source\VTAccessibilityFactory.pas',
  VTHeaderPopup in '..\dependencies\treeview\Source\VTHeaderPopup.pas',
  VirtualTrees in '..\dependencies\treeview\Source\VirtualTrees.pas',
  VirtualTrees.Actions in '..\dependencies\treeview\Source\VirtualTrees.Actions.pas',
  VirtualTrees.Classes in '..\dependencies\treeview\Source\VirtualTrees.Classes.pas',
  VirtualTrees.ClipBoard in '..\dependencies\treeview\Source\VirtualTrees.ClipBoard.pas',
  VirtualTrees.Export in '..\dependencies\treeview\Source\VirtualTrees.Export.pas',
  VirtualTrees.StyleHooks in '..\dependencies\treeview\Source\VirtualTrees.StyleHooks.pas',
  VirtualTrees.Utils in '..\dependencies\treeview\Source\VirtualTrees.Utils.pas',
  VirtualTrees.WorkerThread in '..\dependencies\treeview\Source\VirtualTrees.WorkerThread.pas',
  FHIR.R4.Scint in '..\library\r4\FHIR.R4.Scint.pas',
  ScintFormats in '..\dependencies\ui\ScintFormats.pas',
  FHIR.v2.Scint in '..\library\v2\FHIR.v2.Scint.pas',
  FHIR.Cda.Narrative in '..\library\cda\FHIR.Cda.Narrative.pas',
  FHIR.Base.OIDs in '..\library\base\FHIR.Base.OIDs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTransformerForm, TransformerForm);
  Application.CreateForm(TListSelectorForm, ListSelectorForm);
  Application.CreateForm(TPackageCacheForm, PackageCacheForm);
  Application.CreateForm(TPackageFinderForm, PackageFinderForm);
  Application.Run;
end.
