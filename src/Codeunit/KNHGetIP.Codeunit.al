/// <summary>
/// This codeunit contains a single function that calls an external webservice to get the public IP address of the machine running the codeunit. The function uses HttpClient to send a GET request to the api ipify, which returns the public IP address in JSON format. The function then parses the JSON response to extract and return the IP address as text.
/// </summary>
codeunit 51300 KNHGetIP
{
    procedure GetIP(): Text
    var
        MyHttpClient: HttpClient;
        MyHttpResponseMessage: HttpResponseMessage;
        MyJsonObj: JsonObject;
        MyResponseTxt: Text;
    begin
        if MyHttpClient.Get('https://api.ipify.org?format=json', MyHttpResponseMessage) then begin
            if MyHttpResponseMessage.IsSuccessStatusCode then begin
                MyHttpResponseMessage.Content().ReadAs(MyResponseTxt); //Gets the contents of the http response and reads it into the provided text
                MyJsonObj.ReadFrom(MyResponseTxt); //Reads jsontext into json object variable
                exit(this.GetJsonTextField(MyJsonObj, 'ip'));
            end;
        end else
            if MyHttpResponseMessage.IsBlockedByEnvironment then
                Error('Please turn on "Allow HttpClient Request" from the app''s configure page in Extension Management.');
    end;

    procedure GetJsonTextField(pJsonObj: JsonObject; pMember: Text): Text
    var
        result: JsonToken;
    begin
        if pJsonObj.Get(pMember, result) then
            exit(result.AsValue().AsText()); //Convert json token value to json obj value and then into text parameter
    end;
}
