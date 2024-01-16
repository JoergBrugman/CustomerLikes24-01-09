codeunit 50200 "BSCL Subscriber Store"
{
    [EventSubscriber(ObjectType::Table, Database::"BSB Book", OnBeforeOnDelete, '', false, false)]
    local procedure BSBBookOnBeforeOnDelete(var Rec: Record "BSB Book"; var IsHandled: Boolean);
    var
        Customer: Record Customer;
        OnBeforeOnDeleteBookErr: Label '%1 %2 cannot be deleted because it is already in use.', Comment = '"DEU"=das %1 %2 kann nicht gelöscht werden, da es bereits verwendet wird.';
    begin
        if IsHandled then
            exit;

        Customer.SetCurrentKey("BSB Favorite Book No.");
        Customer.SetRange("BSB Favorite Book No.", Rec."No.");
        if not Customer.IsEmpty then
            Error(OnBeforeOnDeleteBookErr, Rec.TableCaption, Rec."No.");
        IsHandled := true;
    end;
}