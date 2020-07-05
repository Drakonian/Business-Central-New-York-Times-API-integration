table 52000 "NYT API Setup"
{
    Caption = 'New York Times API Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(20; "Base URL"; Text[100])
        {
            Caption = 'Base URL';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    procedure SetAPIKey(NewAPIKey: Text)
    var
        EncryptionManagement: Codeunit "Cryptography Management";
    begin
        if IsolatedStorage.Contains(GetStorageKey(), DataScope::Module) then
            IsolatedStorage.Delete((GetStorageKey()));
        if EncryptionManagement.IsEncryptionEnabled() and EncryptionManagement.IsEncryptionPossible() then
            NewAPIKey := EncryptionManagement.Encrypt(NewAPIKey);

        IsolatedStorage.set(GetStorageKey(), NewAPIKey, DataScope::Module);
    end;

    procedure GetAPIKey(): Text
    var
        EncryptionManagement: Codeunit "Cryptography Management";
        APIKey: Text;
    begin
        if IsolatedStorage.Contains(GetStorageKey(), DataScope::Module) then begin
            IsolatedStorage.Get(GetStorageKey(), DataScope::Module, APIKey);
            if EncryptionManagement.IsEncryptionEnabled() and EncryptionManagement.IsEncryptionPossible() then
                APIKey := EncryptionManagement.Decrypt(APIKey);
            exit(APIKey);
        end;
    end;

    local procedure GetStorageKey(): Text
    begin
        exit(SystemId);
    end;

}
