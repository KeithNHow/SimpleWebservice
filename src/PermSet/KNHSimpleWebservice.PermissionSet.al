/// <summary>
/// PermSet KNH Simple Webservice (ID 51300).
/// </summary>
permissionset 51300 "KNH_SimpleWebservice"
{
    Assignable = true;
    Caption = 'Simple Webservice', MaxLength = 30;
    Permissions =
        codeunit "KNH_GetIP" = X;
}
