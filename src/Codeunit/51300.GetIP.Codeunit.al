/// <summary>
/// Codeunit "GetIP" (ID 51300).
/// </summary>
codeunit 51300 GetIP
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
                response.Content().ReadAs(ResponseTxt); //Gets the contents of the http response and reads it into the provide text
                jsonObj.ReadFrom(responseTxt); //Reads jsontext into json object variable
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
    /// <param name="pJsonObj">JsonObject.</param>  
    /// <param name="pMember">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetJsonTextField(pJsonObj: JsonObject; pMember: Text): Text
    var
        result: JsonToken;
    begin
        if pJsonObj.Get(pMember, result) then
            exit(Result.AsValue().AsText()); //Convert json token value to json obj value and then into text parameter
    end;
}
