(*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *)


program client;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ConsoleHelper in 'ConsoleHelper.pas',
  TestConstants in 'testsuite\TestConstants.pas',
  TestClient in 'testsuite\client\TestClient.pas',
  TestLogger in 'testsuite\client\TestLogger.pas',
  UnitTests in 'testsuite\client\UnitTests.pas',
  PerfTests in 'testsuite\client\Performance\PerfTests.pas',
  DataFactory in 'testsuite\client\Performance\DataFactory.pas',
  Thrift.Test in 'gen-delphi\Thrift.Test.pas',
  Thrift in '..\src\Thrift.pas',
  Thrift.Transport in '..\src\Thrift.Transport.pas',
  Thrift.Socket in '..\src\Thrift.Socket.pas',
  Thrift.Configuration in '..\src\Thrift.Configuration.pas',
  Thrift.Exception in '..\src\Thrift.Exception.pas',
  Thrift.Transport.Pipes in '..\src\Thrift.Transport.Pipes.pas',
  Thrift.Transport.WinHTTP in '..\src\Thrift.Transport.WinHTTP.pas',
  Thrift.Transport.MsxmlHTTP in '..\src\Thrift.Transport.MsxmlHTTP.pas',
  Thrift.Protocol in '..\src\Thrift.Protocol.pas',
  Thrift.Protocol.JSON in '..\src\Thrift.Protocol.JSON.pas',
  Thrift.Protocol.Compact in '..\src\Thrift.Protocol.Compact.pas',
  Thrift.Protocol.Multiplex in '..\src\Thrift.Protocol.Multiplex.pas',
  Thrift.Collections in '..\src\Thrift.Collections.pas',
  Thrift.Server in '..\src\Thrift.Server.pas',
  Thrift.Stream in '..\src\Thrift.Stream.pas',
  Thrift.TypeRegistry in '..\src\Thrift.TypeRegistry.pas',
  Thrift.WinHTTP in '..\src\Thrift.WinHTTP.pas',
  Thrift.Utils in '..\src\Thrift.Utils.pas';

var
  nParamCount : Integer;
  args : array of string;
  i : Integer;
  arg : string;

begin
  try
    Writeln( 'Delphi TestClient '+Thrift.Version);
    nParamCount := ParamCount;
    SetLength( args, nParamCount);
    for i := 1 to nParamCount do begin
      arg := ParamStr( i );
      args[i-1] := arg;
    end;

    ExitCode := TTestClient.Execute( args);

  except
    on E: EAbort do begin
      ExitCode := $FF;
    end;
    on E: Exception do begin
      Writeln(E.ClassName, ': ', E.Message);
      ExitCode := $FF;
    end;
  end;
end.

