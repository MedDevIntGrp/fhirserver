unit FHIR.Web.HtmlGen;

{
Copyright (c) 2011+, HL7 and Health Intersections Pty Ltd (http://www.healthintersections.com.au)
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 * Neither the name of HL7 nor the names of its contributors may be used to
   endorse or promote products derived from this software without specific
   prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
}


interface

uses
  SysUtils,
  FHIR.Support.Base, FHIR.Support.Utilities,
  FHIR.Support.Stream,
  FHIR.Base.Objects, FHIR.Base.Xhtml, FHIR.Base.Lang, FHIR.Base.Factory,
  FHIR.Web.Parsers,
  FHIR.Base.Parser;

Type

  THtmlPublisher = class (TFslObject)
  private
    FBuilder : TStringBuilder;
    FFactory : TFHIRFactory;
    FBaseURL: String;
    FLang: THTTPLanguages;
    FVersion: String;
    FLogId: String;
    function Footer(base : String; const lang : THTTPLanguages; logId: String; tail: boolean = true): string;
    function HeaderX(base : String; const lang : THTTPLanguages; version: String): String;
  public
    constructor Create(factory : TFHIRFactory);
    destructor Destroy; Override;

    procedure Header(s : String);
    procedure Done;

    procedure Line;
    procedure StartPre;
    procedure endPre;

    procedure Heading(level : integer; text : String);
    procedure StartParagraph;
    procedure EndParagraph;
    procedure AddParagraph(text : String = '');
    procedure AddTextPlain(text : String);
    procedure AddTitle(text : String);
    procedure AddText(text : String; bold, italics : boolean);

    procedure URL(text, url : String; hint : string = '');
    procedure ParaURL(text, url : String);

    procedure StartTable(borders : boolean; clss : String = '');
    procedure StartTableRow;
    procedure StartRow(bgcolor : string = '');
    procedure StartTableCell(span : integer = 1);
    procedure EndTableCell;
    procedure EndTableRow;
    procedure EndTable;
    procedure AddTableCellURL(text, url : String; hint : String = '');
    procedure AddTableCell(text : String; bold : boolean = false);
    procedure AddTableCellHint(text, hint : String);

    procedure StartList(ordered : boolean = false);
    procedure EndList(ordered : boolean = false);
    procedure StartListItem;
    procedure EndListItem;
    procedure StartBlockQuote;
    procedure EndBlockQuote;
    procedure startDiv;
    procedure endDiv;

    procedure StartForm(method, action : String);
    procedure TextInput(name : String; length : integer = 20); overload;
    procedure TextInput(name, value : String; length : integer = 20); overload;
    procedure TextInput(name, value, text : String; length : integer = 20); overload;
    procedure Memo(name, value, text : String); overload;
    procedure checkbox(name : String; value : boolean; text : String);
    procedure hiddenInput(name, value : String);
    procedure Submit(name : String);
    procedure EndForm;
    procedure writeXhtml(node : TFhirXHtmlNode);
    procedure Spacer;

    function output : String;
    Property BaseURL : String read FBaseURL write FBaseURL;
    Property Lang : THTTPLanguages read FLang write FLang;
    Property Version : String read FVersion write FVersion;
    Property LogId : String read FLogId write FLogid;
  end;



implementation

{ THtmlPublisher }

procedure THtmlPublisher.AddParagraph(text: String);
begin
  StartParagraph;
  AddTextPlain(text);
  EndParagraph;
end;

procedure THtmlPublisher.AddTableCell(text: String; bold: boolean);
begin
  StartTableCell;
  addtext(text, bold, false);
  EndTableCell;
end;

procedure THtmlPublisher.AddTableCellHint(text, hint: String);
begin
  StartTableCell;
  FBuilder.Append('<span title="'+FormatTextToXML(hint, xmlAttribute)+'">');
  addtext(text, false, false);
  FBuilder.Append('</span>');
  EndTableCell;
end;

procedure THtmlPublisher.AddTableCellURL(text, url: String; hint : String = '');
begin
  StartTableCell;
  self.URL(text, url, hint);
  EndTableCell;
end;

procedure THtmlPublisher.AddText(text: String; bold, italics: boolean);
begin
  if bold then
    FBuilder.Append('<b>');
  if italics then
    FBuilder.Append('<i>');
  AddTextPlain(text);
  if italics then
    FBuilder.Append('</i>');
  if bold then
    FBuilder.Append('</b>');
end;

procedure THtmlPublisher.AddTextPlain(text: String);
begin
  FBuilder.Append(FormatTextToXml(text, xmlText));
end;

procedure THtmlPublisher.AddTitle(text: String);
begin
  AddText(text, true, false);
end;

procedure THtmlPublisher.checkbox(name : String; value : boolean; text : String);
begin
  if value then
    FBuilder.Append('<input type="checkbox" name="'+name+'" checked value="1"/> '+text)
  else
    FBuilder.Append('<input type="checkbox" name="'+name+'" value="1"/> '+text);
end;

procedure THtmlPublisher.endDiv;
begin
  FBuilder.Append('</div>')
end;

constructor THtmlPublisher.Create;
begin
  inherited Create;
  FBuilder := TStringBuilder.create;
  FFactory := factory;
end;

destructor THtmlPublisher.Destroy;
begin
  FBuilder.Free;
  FFactory.Free;
  inherited;
end;

function THtmlPublisher.Footer(base : String; const lang : THTTPLanguages; logId : String; tail : boolean = true): string;
begin
  result :=
    '</div>'+#13#10+
    ''+#13#10+
    ''+#13#10+
    '				</div>  <!-- /inner-wrapper -->'+#13#10+
    '            </div>  <!-- /row -->'+#13#10+
    '        </div>  <!-- /container -->'+#13#10+
    '    </div>  <!-- /segment-content -->'+#13#10+
    ''+#13#10+
    ''+#13#10+
    '	<div id="segment-footer" class="segment">  <!-- segment-footer -->'+#13#10+
    '		<div class="container">  <!-- container -->'+#13#10+
    '			<div class="inner-wrapper">'+#13#10+
    '				<p>'+#13#10+
    '        <a href="'+base+'" style="color: gold">'+GetFhirMessage('SERVER_HOME', lang)+'</a>.&nbsp;|&nbsp;FHIR &copy; HL7.org 2011+. &nbsp;|&nbsp; FHIR '+GetFhirMessage('NAME_VERSION', lang)+' <a href="'+Ffactory.specUrl+'" style="color: gold">'+FFactory.versionString+'</a>'+#13#10+
    '        | Request-id: '+logId+
    '        </span>'+#13#10+
    '        </p>'+#13#10+
    '			</div>  <!-- /inner-wrapper -->'+#13#10+
    '		</div>  <!-- /container -->'+#13#10+
    '	</div>  <!-- /segment-footer -->'+#13#10+
    ''+#13#10+
    ''+#13#10+
    '	<div id="segment-post-footer" class="segment hidden">  <!-- segment-post-footer -->'+#13#10+
    '		<div class="container">  <!-- container -->'+#13#10+
    '		</div>  <!-- /container -->'+#13#10+
    '	</div>  <!-- /segment-post-footer -->'+#13#10+
    ''+#13#10+
    ''+#13#10+
    ''+#13#10+
    ''+#13#10+
    ''+#13#10+
    '      <!-- JS and analytics only. -->'+#13#10+
    '      <!-- Bootstrap core JavaScript'+#13#10+
    '================================================== -->'+#13#10+
    '  <!-- Placed at the end of the document so the pages load faster -->'+#13#10+
    '<script src="/assets/js/jquery.js"/>'+#13#10+
    '<script src="/dist/js/bootstrap.min.js"/>'+#13#10+
    '<script src="/assets/js/respond.min.js"/>'+#13#10+
    ''+#13#10+
    '<script src="/assets/js/fhir.js"/>'+#13#10+
    ''+#13#10+
    '  <!-- Analytics Below'+#13#10+
    '================================================== -->'+#13#10+
    ''+#13#10+
    ''+#13#10+
    ''+#13#10;
if tail then
  result := result +
    '</body>'+#13#10+
    '</html>'+#13#10;
end;


procedure THtmlPublisher.Done;
begin
  FBuilder.Append(footer(BaseURL, lang, logid));
end;

procedure THtmlPublisher.EndBlockQuote;
begin
  FBuilder.Append('</blockquote>'#13#10);
end;

procedure THtmlPublisher.EndForm;
begin
  FBuilder.Append('</form>'#13#10);
end;

procedure THtmlPublisher.EndList(ordered: boolean);
begin
  if ordered then
    FBuilder.Append('</ol>'#13#10)
  else
    FBuilder.Append('</ul>'#13#10);
end;

procedure THtmlPublisher.EndListItem;
begin
  FBuilder.Append('</li>'#13#10);
end;

procedure THtmlPublisher.EndParagraph;
begin
  FBuilder.Append('<p>'#13#10);
end;

procedure THtmlPublisher.endPre;
begin
  FBuilder.Append('<pre>'#13#10);
end;

procedure THtmlPublisher.EndTable;
begin
  FBuilder.Append('</table>'#13#10);
end;

procedure THtmlPublisher.EndTableCell;
begin
  FBuilder.Append('</td>'#13#10);
end;

procedure THtmlPublisher.EndTableRow;
begin
  FBuilder.Append('</tr>'#13#10);
end;

function THtmlPublisher.HeaderX(base : String; const lang : THTTPLanguages; version: String): String;
begin
  result :=
    '	<div id="segment-navbar" class="segment">  <!-- segment-breadcrumb -->'+#13#10+
    '		<div id="stripe"> </div>'+#13#10+
    '		<div class="container">  <!-- container -->'+#13#10+
    '		<div style="background-color: #ad1f2f; padding: 6px; color: white;">  <!-- container -->'+#13#10;


  result := result +
    '  <a href="http://www.hl7.org/fhir" style="color: gold" title="'+GetFhirMessage('MSG_HOME_PAGE_TITLE', lang)+'"><img border="0" src="/icon-fhir-16.png" style="vertical-align: text-bottom"/> <b>FHIR</b></a>'#13#10+
    ''#13#10+
    '  &copy; HL7.org'#13#10+
    '  &nbsp;|&nbsp;'#13#10+
    '  <a href="/" style="color: gold">'+GetFhirMessage('SERVER_HOME', lang)+'</a> '+
    '  &nbsp;|&nbsp;'#13#10+
    '  <a href="http://www.healthintersections.com.au" style="color: gold">Health Intersections</a> '+GetFhirMessage('NAME_SERVER', lang)+' v'+version+#13#10+
    '  &nbsp;|&nbsp;'#13#10+
    '  <a href="'+Ffactory.specUrl+'" style="color: gold">FHIR '+GetFhirMessage('NAME_VERSION', lang)+' '+FFactory.versionString+'</a>'#13#10;

  result := result +
    '  &nbsp;'#13#10+
    '		</div>  <!-- /container -->'+#13#10+
    '		</div>  <!-- /container -->'+#13#10+
    '</div>'#13#10+
    ''#13#10;
//    if FFacebookLike and (FOauthUrl <> '') then
//      result := result + '<iframe src="https://www.facebook.com/plugins/like.php?href='+FOauthUrl+'" scrolling="no" frameborder="0" style="border:none; width:450px; height:30px"></iframe>'#13#10;

  result := result +
    '	<!-- /segment-breadcrumb -->'+#13#10+
    ''+#13#10+
    '	<div id="segment-content" class="segment">  <!-- segment-content -->'+#13#10+
    '	<div class="container">  <!-- container -->'+#13#10+
    '            <div class="row">'+#13#10+
    '            	<div class="inner-wrapper">'+#13#10+
    ' <div id="div-cnt" class="col-9">'+#13#10+
    ''+#13#10+
    ''+#13#10;
end;

function PageLinks: String;
begin
  result :=
    '  <meta charset="utf-8"/>'+#13#10+
    '  <meta charset="utf-8" http-equiv="X-UA-Compatible" content="IE=edge" />'+#13#10+
    '  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>'+#13#10+
    '  <meta content="http://hl7.org/fhir" name="author"/>'+#13#10+
    ''+#13#10+
    '  <link rel="stylesheet" href="/fhir.css"/>'+#13#10+
    ''+#13#10+
    ''+#13#10+
    '    <!-- Bootstrap core CSS -->'+#13#10+
    '  <link rel="stylesheet" href="/dist/css/bootstrap.css"/>'+#13#10+
    '  <link rel="stylesheet" href="/assets/css/bootstrap-fhir.css"/>'+#13#10+
    ''+#13#10+
    '    <!-- Project extras -->'+#13#10+
    '  <link rel="stylesheet" href="/assets/css/project.css"/>'+#13#10+
    '  <link rel="stylesheet" href="/assets/css/pygments-manni.css"/>'+#13#10+
    ''+#13#10+
    '    <!-- FHIR Server stuff -->'+#13#10+
    '  <link rel="stylesheet" href="/css/tags.css"/>'+#13#10+
    ''+#13#10+
    '    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->'+#13#10+
    '    <!-- [if lt IE 9]>'+#13#10+
    '  <script src="/assets/js/html5shiv.js"></script>'+#13#10+
    '  <script src="/assets/js/respond.min.js"></script>'+#13#10+
    '  <![endif] -->'+#13#10+
    ''+#13#10+
    '    <!-- Favicons -->'+#13#10+
    '  <link sizes="144x144" rel="apple-touch-icon-precomposed" href="/assets/ico/apple-touch-icon-144-precomposed.png"/>'+#13#10+
    '  <link sizes="114x114" rel="apple-touch-icon-precomposed" href="/assets/ico/apple-touch-icon-114-precomposed.png"/>'+#13#10+
    '  <link sizes="72x72" rel="apple-touch-icon-precomposed" href="/assets/ico/apple-touch-icon-72-precomposed.png"/>'+#13#10+
    '  <link rel="apple-touch-icon-precomposed" href="/assets/ico/apple-touch-icon-57-precomposed.png"/>'+#13#10+
    '  <link rel="shortcut icon" href="/assets/ico/favicon.png"/>'+#13#10;
end;


procedure THtmlPublisher.Header(s: String);
begin
  FBuilder.Append(
  '<?xml version="1.0" encoding="UTF-8"?>'#13#10+
  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"'#13#10+
  '       "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'#13#10+
  ''#13#10+
  '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">'#13#10+
  '<head>'#13#10+
  '    <title>'+s+'FHIR Server</title>'#13#10+
  pagelinks+
  FHIR_JS+
  '</head>'#13#10+
  ''#13#10+
  '<body>'#13#10+
  HeaderX(BaseURL, FLang, Version)+
  '<h1>'+s+'</h1>'#13#10);
end;

procedure THtmlPublisher.Heading(level: integer; text: String);
begin
  FBuilder.Append('<h'+inttostr(level)+'>');
  AddTextPlain(text);
  FBuilder.Append('</h'+inttostr(level)+'>');
end;

procedure THtmlPublisher.hiddenInput(name, value: String);
begin
  FBuilder.Append('<input type="hidden" name="'+name+'" value="'+value+'"/>');
end;


procedure THtmlPublisher.Line;
begin
  FBuilder.Append('<hr/>'#13#10);
end;

procedure THtmlPublisher.Memo(name, value, text: String);
begin
  FBuilder.Append(text+'<textArea name="'+name+'">'#13#10+value+'</textArea>');
end;

function THtmlPublisher.output: String;
begin
  result := FBuilder.ToString;
end;

procedure THtmlPublisher.ParaURL(text, url: String);
begin
  StartParagraph;
  self.URL(text, url);
  EndParagraph;
end;

procedure THtmlPublisher.Spacer;
begin
  FBuilder.Append('&nbsp;');
end;

procedure THtmlPublisher.StartBlockQuote;
begin
  FBuilder.Append('<blockquote>');
end;

procedure THtmlPublisher.startDiv;
begin
  FBuilder.Append('<div>')
end;

procedure THtmlPublisher.StartForm(method, action: String);
begin
  FBuilder.Append('<form method="'+method+'" action="'+action+'">'#13#10);
end;

procedure THtmlPublisher.StartList(ordered: boolean);
begin
  if ordered then
    FBuilder.Append('<ol>')
  else
    FBuilder.Append('<ul>');
end;

procedure THtmlPublisher.StartListItem;
begin
  FBuilder.Append('<li>');
end;

procedure THtmlPublisher.StartParagraph;
begin
  FBuilder.Append('<p>');
end;

procedure THtmlPublisher.StartPre;
begin
  FBuilder.Append('<pre>'#13#10);
end;

procedure THtmlPublisher.StartRow(bgcolor : string = '');
begin
  if (bgcolor <> '') then
    FBuilder.Append('<tr style="background-color: '+bgcolor+'">')
  else
    FBuilder.Append('<tr>')
end;

procedure THtmlPublisher.StartTable(borders: boolean; clss : String);
begin
  if clss <> '' then
    clss := ' class="'+clss+'"';
  if borders then
    FBuilder.Append('<table border="1"'+clss+'>')
  else
    FBuilder.Append('<table border="0"'+clss+'>');
end;

procedure THtmlPublisher.StartTableCell;
begin
  if (span <> 1) then
    FBuilder.Append('<td colspan="'+inttostr(span)+'">')
  else
   FBuilder.Append('<td>')
end;

procedure THtmlPublisher.StartTableRow;
begin
  FBuilder.Append('<tr>')
end;

procedure THtmlPublisher.Submit(name: String);
begin
  FBuilder.Append('<input type="submit" value="'+name+'"/>');
end;

procedure THtmlPublisher.TextInput(name, value: String; length: integer);
begin
  FBuilder.Append('<input type="text" name="'+name+'" value="'+value+'" size="'+inttostr(length)+'"/>');
end;

procedure THtmlPublisher.TextInput(name: String; length: integer);
begin
  FBuilder.Append('<input type="text" name="'+name+'" size="'+inttostr(length)+'"/>');
end;

procedure THtmlPublisher.URL(text, url, hint: String);
begin
  if (hint <> '') then
    FBuilder.Append('<a href="'+url+'" title="'+FormatTextToXml(hint, xmlAttribute)+'">')
  else
    FBuilder.Append('<a href="'+url+'">');
  AddTextPlain(text);
  FBuilder.Append('</a>');
end;

procedure THtmlPublisher.writeXhtml(node: TFhirXHtmlNode);
var
  i : integer;
begin
  case node.NodeType of
    fhntElement, fhntDocument:
      begin
        FBuilder.Append('<'+node.Name);
        for i := 0 to node.Attributes.Count - 1 do
          FBuilder.Append(' '+node.Attributes[i].Name+'="'+FormatTextToXml(node.Attributes[i].value, xmlAttribute)+'"');
        if node.ChildNodes.Count = 0 then
          FBuilder.Append('/>')
        else
        begin
          FBuilder.Append('>');
          for i := 0 to node.ChildNodes.Count - 1 do
            writeXhtml(node.ChildNodes[i]);
          FBuilder.Append('</'+node.Name+'>');
        end;
      end;
    fhntText:
      AddTextPlain(node.Content);
    fhntComment:
      FBuilder.Append('<!-- '+FormatTextToXml(node.Content, xmlText)+' -->');
  end;
end;

procedure THtmlPublisher.TextInput(name, value, text: String; length: integer);
begin
  FBuilder.Append('<input type="text" name="'+name+'" value="'+value+'" size="'+inttostr(length)+'"/> '+text);
end;

end.
