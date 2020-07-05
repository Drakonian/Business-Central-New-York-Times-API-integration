page 52000 "NYT API Setup"
{

    Caption = 'New York Times API Setup';
    PageType = Card;
    SourceTable = "NYT API Setup";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Base URL"; "Base URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Base URL';
                }
                field(APIKey; APIKey)
                {
                    ApplicationArea = All;
                    Caption = 'API Key';
                    ToolTip = 'Specifies the API Key';
                    ExtendedDatatype = Masked;
                    trigger OnValidate()
                    begin
                        SetAPIKey(APIKey);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Get() then begin
            Init();
            Insert();
        end;
        if GetAPIKey() <> '' then
            APIKey := '****';
    end;

    var
        APIKey: Text;
}
