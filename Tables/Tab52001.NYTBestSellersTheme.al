table 52001 "NYT Best Sellers Theme"
{
    Caption = 'Best Sellers List of Themes';
    DataClassification = CustomerContent;

    fields
    {
        field(10; "List Name"; Text[250])
        {
            Caption = 'List Name';
            DataClassification = CustomerContent;
        }
        field(20; "Oldest Published Date"; Date)
        {
            Caption = 'Oldest Published Date';
            DataClassification = CustomerContent;
        }
        field(30; "Newest Published Date"; Date)
        {
            Caption = 'Newest Published Date';
            DataClassification = CustomerContent;
        }
        field(40; Updated; Text[30])
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50; "List Name Encoded"; Text[250])
        {
            Caption = 'List Name Encoded';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "List Name")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        NYTBestSellers: Record "NYT Best Sellers";
    begin
        NYTBestSellers.SetRange("List Name", Rec."List Name");
        if not NYTBestSellers.IsEmpty() then
            NYTBestSellers.DeleteAll();
    end;
}
