page 52002 "NYT Best Sellers"
{

    Caption = 'Best Sellers';
    PageType = List;
    SourceTable = "NYT Best Sellers";
    UsageCategory = None;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    DataCaptionFields = "List Name";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Book Title"; "Book Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Book Title';
                }
                field("Book Description"; "Book Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Book Description';
                }
                field("Book Author"; "Book Author")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Book Author';
                }
                field("Amazon URL"; "Amazon URL")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Amazon URL';
                    ExtendedDatatype = URL;
                }
            }
        }
    }

}
