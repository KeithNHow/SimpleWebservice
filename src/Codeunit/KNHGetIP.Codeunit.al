/// <summary>
/// Codeunit "KNH_GetIP" (ID 51300).
/// </summary>
codeunit 51300 "KNH_GetIP"
{
    /// <summary>
    /// GetIP.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetIP(): Text
    var
        MyHttpClient: HttpClient;
        MyHttpResponseMessage: HttpResponseMessage;
        MyJsonObj: JsonObject;
        MyResponseTxt: Text;
    begin
        if MyHttpClient.Get('https://api.ipify.org?format=json', MyHttpResponseMessage) then begin
            if MyHttpResponseMessage.IsSuccessStatusCode then begin
                MyHttpResponseMessage.Content().ReadAs(MyResponseTxt); //Gets the contents of the http response and reads it into the provide text
                MyJsonObj.ReadFrom(MyResponseTxt); //Reads jsontext into json object variable
                exit(GetJsonTextField(MyJsonObj, 'ip'));
            end;
        end else
            if MyHttpResponseMessage.IsBlockedByEnvironment then
                Error('Please turn on "Allow HttpClient Request" from the app''s configure page in Extension Management.');
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
