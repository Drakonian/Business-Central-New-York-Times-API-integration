table 52002 "NYT Best Sellers"
{
    Caption = 'Best Sellers Book';
    DataClassification = CustomerContent;

    fields
    {
        field(10; "List Name"; Text[250])
        {
            Caption = 'List Name';
            DataClassification = CustomerContent;
        }
        field(20; "Line No."; BigInteger)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(30; "Book Title"; Text[250])
        {
            Caption = 'Book Title';
            DataClassification = CustomerContent;
        }
        field(40; "Book Description"; Text[2048])
        {
            Caption = 'Book Description';
            DataClassification = CustomerContent;
        }
        field(50; "Book Author"; Text[250])
        {
            Caption = 'Book Author';
            DataClassification = CustomerContent;
        }
        field(60; "Amazon URL"; Text[250])
        {
            Caption = 'Amazon URL';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
    }
    keys
    {
        key(PK; "List Name", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Line No." := GetNextLineNo();
    end;

    procedure GetNextLineNo(): BigInteger
    var
        NYTBestSellers: Record "NYT Best Sellers";
    begin
        NYTBestSellers.SetRange("List Name", "List Name");
        if NYTBestSellers.FindLast() then
            exit(NYTBestSellers."Line No." + 1);
        exit(1);
    end;
}
