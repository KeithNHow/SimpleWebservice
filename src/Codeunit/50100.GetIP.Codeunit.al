/// <summary>
/// Codeunit "GetIP" (ID 50100).
/// </summary>
codeunit 50100 GetIP
{
    /// <summary>
    /// GetIP.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetIP(): Text
    var
        client: HttpClient;
        response: HttpResponseMessage;
        jsonObj: JsonObject;
        responseTxt: Text;
    begin
        if client.Get('https://api.ipify.org?format=json', response) then begin
            if response.IsSuccessStatusCode then begin
                response.Content().ReadAs(ResponseTxt);
                jsonObj.ReadFrom(responseTxt);
                exit(GetJsonTextField(jsonObj, 'ip'));
            end;
        end else begin
            if response.IsBlockedByEnvironment then begin
                Error('Please turn on "Allow HttpClient Request" from the app''s configure page in Extension Management.');
            end;
        end;
    end;

    /// <summary>
    /// GetJsonTextField.
    /// </summary>
    /// <param name="O">JsonObject.</param>  
    /// <param name="Member">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetJsonTextField(O: JsonObject; Member: Text): Text
    var
        result: JsonToken;
    begin
        if O.get(Member, result) then begin
            exit(Result.AsValue().AsText());
        end;
    end;
}
