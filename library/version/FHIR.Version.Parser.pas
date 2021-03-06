unit FHIR.Version.Parser;

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

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
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

// FHIR v3.1.0 generated 2017-07-09T00:15:31+10:00

uses
  SysUtils, Classes,
  FHIR.Support.Base, FHIR.Support.Stream, FHIR.Support.Xml,
  FHIR.Base.Objects, FHIR.Base.Parser, FHIR.Base.Lang,

  {$IFDEF FHIR2}
  FHIR.R2.Types, FHIR.R2.Resources, FHIR.R2.Xml, FHIR.R2.Json, FHIR.R2.Context, FHIR.R2.Parser;
  {$ENDIF}
  {$IFDEF FHIR3}
  FHIR.R3.Types, FHIR.R3.Resources, FHIR.R3.Xml, FHIR.R3.Json, FHIR.R3.Turtle, FHIR.R3.Context, FHIR.R3.Parser;
  {$ENDIF}
  {$IFDEF FHIR4}
  FHIR.R4.Types, FHIR.R4.Resources, FHIR.R4.Xml, FHIR.R4.Json, FHIR.R4.Turtle, FHIR.R4.Context, FHIR.R4.Parser;
  {$ENDIF}

Type
  TFHIRParser = FHIR.Base.Parser.TFHIRParser;
  TFHIRComposer = FHIR.Base.Parser.TFHIRComposer;

  {$IFDEF FHIR2}
  TFHIRXmlParser = FHIR.R2.Xml.TFHIRXmlParser;
  TFHIRXmlComposer = FHIR.R2.Xml.TFHIRXmlComposer;
  TFHIRJsonParser = FHIR.R2.Json.TFHIRJsonParser;
  TFHIRJsonComposer = FHIR.R2.Json.TFHIRJsonComposer;
  TFHIRParsers = TFHIRParsers2;
  {$ENDIF}
  {$IFDEF FHIR3}
  TFHIRXmlParser = FHIR.R3.Xml.TFHIRXmlParser;
  TFHIRXmlComposer = FHIR.R3.Xml.TFHIRXmlComposer;
  TFHIRJsonParser = FHIR.R3.Json.TFHIRJsonParser;
  TFHIRJsonComposer = FHIR.R3.Json.TFHIRJsonComposer;
  TFHIRTurtleComposer = FHIR.R3.Turtle.TFHIRTurtleComposer;
  TFHIRTurtleParser = FHIR.R3.Turtle.TFHIRTurtleParser;
  TFHIRParsers = TFHIRParsers3;
  {$ENDIF}
  {$IFDEF FHIR4}
  TFHIRXmlParser = FHIR.R4.Xml.TFHIRXmlParser;
  TFHIRXmlComposer = FHIR.R4.Xml.TFHIRXmlComposer;
  TFHIRJsonParser = FHIR.R4.Json.TFHIRJsonParser;
  TFHIRJsonComposer = FHIR.R4.Json.TFHIRJsonComposer;
  TFHIRTurtleComposer = FHIR.R4.Turtle.TFHIRTurtleComposer;
  TFHIRTurtleParser = FHIR.R4.Turtle.TFHIRTurtleParser;
  TFHIRParsers = TFHIRParsers4;
  {$ENDIF}


implementation

end.

