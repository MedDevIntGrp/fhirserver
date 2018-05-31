unit FHIR.R2.Base;

interface

uses
  FHIR.Base.Objects;

type
  TFHIRObject2 = class (TFHIRObject)
  protected
    function makeStringValue(v : String) : TFHIRObject; override;
    function makeCodeValue(v : String) : TFHIRObject; override;
    function makeIntValue(v : String) : TFHIRObject; override;
    function GetFhirObjectVersion: TFHIRVersion; override;
  end;

  TFHIRObjectX = TFHIRObject2;

  TFHIRResource2 = class (TFHIRResourceV)
  protected
    function makeStringValue(v : String) : TFHIRObject; override;
    function makeCodeValue(v : String) : TFHIRObject; override;
    function makeIntValue(v : String) : TFHIRObject; override;
    function GetFhirObjectVersion: TFHIRVersion; override;
  end;

  TFHIRResourceX = TFHIRResource2;

implementation

uses
  FHIR.R2.Types;


{ TFHIRObject2 }

function TFHIRObject2.GetFhirObjectVersion: TFHIRVersion;
begin
  result := fhirVersionRelease2;
end;

function TFHIRObject2.makeCodeValue(v: String): TFHIRObject;
begin
  result := TFhirCode.Create(v);
end;

function TFHIRObject2.makeIntValue(v: String): TFHIRObject;
begin
  result := TFhirInteger.Create(v);
end;

function TFHIRObject2.makeStringValue(v: String): TFHIRObject;
begin
  result := TFhirString.Create(v);
end;


{ TFHIRResource2 }

function TFHIRResource2.GetFhirObjectVersion: TFHIRVersion;
begin
  result := fhirVersionRelease2;
end;

function TFHIRResource2.makeCodeValue(v: String): TFHIRObject;
begin
  result := TFhirCode.Create(v);
end;

function TFHIRResource2.makeIntValue(v: String): TFHIRObject;
begin
  result := TFhirInteger.Create(v);
end;

function TFHIRResource2.makeStringValue(v: String): TFHIRObject;
begin
  result := TFhirString.Create(v);
end;

end.
