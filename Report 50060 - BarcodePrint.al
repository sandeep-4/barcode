report 50060 "Barcode Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Bar Code/Barcode.rdl';
    AdditionalSearchTerms = 'Barcode priority';
    //ApplicationArea = Basic, Suite;
    Caption = 'Barcode Print';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            column(No__2; "No. 2")
            {

            }
            column(Description; Description)
            {

            }
            column(CompanyName; CompanyInformation.Name)
            {

            }
            column(CompanyPicture; CompanyInformation.Picture)
            {

            }
            column(TempBlobRec_Blob; TempBlobRec.Blob)
            {

            }
            trigger OnAfterGetRecord()
            begin
                BarcodeMgt.EncodeCode128("No.", 1, false, TempBlobRec);
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        TempBlobRec: Record TempBlob;
        BarcodeMgt: Codeunit "Barcode Management";
        CompanyInformation: Record "Company Information";
}