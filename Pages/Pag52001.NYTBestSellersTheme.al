page 52001 "NYT Best Sellers Theme"
{

    ApplicationArea = All;
    Caption = 'Best Sellers Theme List';
    PageType = List;
    SourceTable = "NYT Best Sellers Theme";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("List Name"; "List Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the List Name';
                }
                field("Newest Published Date"; "Newest Published Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Newest Published Date';
                }
                field("Oldest Published Date"; "Oldest Published Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Oldest Published Date';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SyncLatestData)
            {
                ApplicationArea = All;
                Caption = 'Sync Latest Data';
                ToolTip = 'Sync Latest Data';
                Image = RefreshLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    NYTApiMgt: Codeunit "NYT API Management";
                begin
                    NYTApiMgt.SyncBookAPIData();
                    CurrPage.Update(false);
                end;
            }
            action(OpenBestSellersList)
            {
                ApplicationArea = All;
                Caption = 'Open Best Sellers List';
                ToolTip = 'Open Best Sellers List';
                Image = List;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ShortcutKey = Return;
                trigger OnAction()
                var
                    NYTBestSellers: Record "NYT Best Sellers";
                    NYTBestSellersPage: Page "NYT Best Sellers";
                begin
                    NYTBestSellers.SetRange("List Name", "List Name");
                    NYTBestSellersPage.SetTableView(NYTBestSellers);
                    NYTBestSellersPage.RunModal();
                end;
            }
        }
    }
}
