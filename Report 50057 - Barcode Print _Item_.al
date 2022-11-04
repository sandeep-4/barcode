// report 50057 "Barcode Print (Item)"
// {
//     // version BARCODE1.00

//     DefaultLayout = RDLC;
//     RDLCLayout = 'Bar Code/Barcode Print (Item).rdl';

//     dataset
//     {
//         dataitem(Item; Item)
//         {
//             column(Item__No__; "No.")
//             {
//             }
//             column(Item_Description; DescriptionTxt)
//             {
//             }
//             column(recTempBlob_Blob; recTempBlob.Blob)
//             {
//             }
//             column(Qty; Qty)
//             {
//             }
//             column(SellingPrice; FORMAT(SellingPrice))
//             {
//             }
//             dataitem(CopyLoop; Integer)
//             {
//                 DataItemTableView = SORTING(Number);
//                 column(OutputNo; OutputNo)
//                 {
//                 }

//                 trigger OnAfterGetRecord();
//                 begin
//                     IF Number > 1 THEN BEGIN
//                         OutputNo += 1;
//                     END;
//                 end;

//                 trigger OnPreDataItem();
//                 begin
//                     NoOfLoops := ABS(NoOfCopies);
//                     IF NoOfLoops <= 0 THEN
//                         NoOfLoops := 1;
//                     SETRANGE(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                 end;
//             }

//             trigger OnAfterGetRecord();
//             begin
//                 BarCodeCdnt.EncodeCode128("No.", 1, FALSE, recTempBlob);
//                 NoOfCopies := Qty;

//                 DescriptionTxt := COPYSTR(Item.Description, 1, 25);

//                 Item.RESET;
//                 Item.SETRANGE("No.", "No.");
//                 IF Item."Include SP in Barcode" THEN BEGIN
//                     Location.RESET;
//                     Location.SETRANGE(Code, UserSetup."Default Location Code");
//                     Location.FINDFIRST;
//                     IF Location."Customer Price Group" = '' THEN BEGIN
//                         SalesPrice.RESET;
//                         SalesPrice.SETRANGE("Item No.", "No.");
//                         SalesPrice.SETRANGE("Minimum Quantity", 0);
//                         SalesPrice.SETRANGE("Sales Code", 'RSP');
//                         SalesPrice.SETRANGE("Ending Date", 0D);
//                         IF SalesPrice.FINDLAST THEN
//                             SellingPrice := 'Rs. ' + FORMAT(SalesPrice."Unit Price");
//                     END ELSE BEGIN
//                         SalesPrice.RESET;
//                         SalesPrice.SETRANGE("Item No.", "No.");
//                         SalesPrice.SETRANGE("Minimum Quantity", 0);
//                         SalesPrice.SETRANGE("Sales Code", Location."Customer Price Group");
//                         SalesPrice.SETRANGE("Ending Date", 0D);
//                         IF SalesPrice.FINDLAST THEN
//                             SellingPrice := 'Rs. ' + FORMAT(SalesPrice."Unit Price");
//                     END;
//                 END;
//                 //Sameer
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 group("Please Enter the quantity")
//                 {
//                     field(Quantity; Qty)
//                     {
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }



//     trigger OnPreReport();
//     begin
//         UserSetup.GET(USERID);
//     end;

//     var
//         BarCodeCdnt: Codeunit "Barcode Management";
//         recTempBlob: Record TempBlob;
//         Qty: Decimal;
//         NoOfLoops: Integer;
//         NoOfCopies: Integer;
//         OutputNo: Integer;
//         UserSetup: Record "User Setup";
//         Location: Record Location;
//         SalesPrice: Record "Sales Price";
//         SellingPrice: Text;
//         DescriptionTxt: Text;
// }

