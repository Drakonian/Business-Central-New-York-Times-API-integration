codeunit 52001 "NYT JSON Mgt"
{
    procedure SelectJsonToken(JObject: JsonObject; Path: Text): Text
    var
        JToken: JsonToken;
    begin
        if JObject.SelectToken(Path, JToken) then
            if NOT JToken.AsValue().IsNull() then
                exit(JToken.AsValue().AsText());
    end;

    procedure GetValueAsText(JToken: JsonToken; ParamString: Text): Text
    var
        JObject: JsonObject;
    begin
        JObject := JToken.AsObject();
        exit(SelectJsonToken(JObject, ParamString));
    end;

    local procedure EvaluateUTCDateTime(DataTimeText: Text) EvaluatedDateTime: DateTime;
    var
        TypeHelper: Codeunit "Type Helper";
        ValueTest: Variant;
    begin
        ValueTest := EvaluatedDateTime;
        IF TypeHelper.Evaluate(ValueTest, DataTimeText, '', TypeHelper.GetCultureName()) THEN
            EvaluatedDateTime := ValueTest;
    end;

    procedure UpdateBestSellersTheme(Data: text)
    var
        NYTBestSellersTheme: Record "NYT Best Sellers Theme";
        JToken: JsonToken;
        JObject: JsonObject;
        JArray: JsonArray;
    begin
        if Data = '' then
            exit;

        JToken.ReadFrom(Data);
        JObject := JToken.AsObject();
        JObject.SelectToken('results', JToken);
        JArray := JToken.AsArray();

        foreach JToken in JArray do begin
            NYTBestSellersTheme.Init();
            NYTBestSellersTheme."List Name" := CopyStr(GetValueAsText(JToken, 'list_name'), 1, MaxStrLen(NYTBestSellersTheme."List Name"));
            NYTBestSellersTheme."List Name Encoded" := CopyStr(GetValueAsText(JToken, 'list_name_encoded'), 1, MaxStrLen(NYTBestSellersTheme."List Name Encoded"));
            NYTBestSellersTheme.Updated := CopyStr(GetValueAsText(JToken, 'updated'), 1, MaxStrLen(NYTBestSellersTheme.Updated));
            NYTBestSellersTheme."Newest Published Date" := DT2Date(EvaluateUTCDateTime(GetValueAsText(JToken, 'newest_published_date')));
            NYTBestSellersTheme."Oldest Published Date" := DT2Date(EvaluateUTCDateTime(GetValueAsText(JToken, 'oldest_published_date')));
            NYTBestSellersTheme.Insert();
        end;
    end;

    procedure UpdateBestSeller(Data: Text)
    var
        NYTBestSellers: Record "NYT Best Sellers";
        JToken: JsonToken;
        JToken2: JsonToken;
        JObject: JsonObject;
        JObject2: JsonObject;
        JArray: JsonArray;
        JArray2: JsonArray;
    begin
        if Data = '' then
            exit;

        JToken.ReadFrom(Data);
        JObject := JToken.AsObject();
        JObject.SelectToken('results', JToken);
        JArray := JToken.AsArray();

        foreach JToken in JArray do begin
            NYTBestSellers.Init();
            NYTBestSellers."List Name" := CopyStr(GetValueAsText(JToken, 'list_name'), 1, MaxStrLen(NYTBestSellers."List Name"));
            NYTBestSellers."Amazon URL" := CopyStr(GetValueAsText(JToken, 'amazon_product_url'), 1, MaxStrLen(NYTBestSellers."Amazon URL"));
            JObject2 := JToken.AsObject();
            if JObject2.SelectToken('book_details', Jtoken2) then begin
                JArray2 := JToken2.AsArray();
                foreach JToken2 in JArray2 do begin
                    NYTBestSellers."Book Title" := CopyStr(GetValueAsText(JToken2, 'title'), 1, MaxStrLen(NYTBestSellers."Book Title"));
                    NYTBestSellers."Book Description" := CopyStr(GetValueAsText(JToken2, 'description'), 1, MaxStrLen(NYTBestSellers."Book Title"));
                    NYTBestSellers."Book Author" := CopyStr(GetValueAsText(JToken2, 'author'), 1, MaxStrLen(NYTBestSellers."Book Author"));
                end;
            end;
            NYTBestSellers.Insert(true);
        end;

    end;
}