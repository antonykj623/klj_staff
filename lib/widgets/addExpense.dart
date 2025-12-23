import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:kljcafe_staff_new/domain/qr_entity.dart';
import 'package:kljcafe_staff_new/utils/apputils.dart';
import 'package:qr_flutter/qr_flutter.dart';


import '../domain/expense_data_entity.dart';
import '../web/api_credentials.dart';
import '../web/webcallRepository.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  DateTime? selectedDate=DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String paymentMethod = "amount"; // default
  bool showQr = false;
   String data = "";


  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense"),

        elevation: 0,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body:  Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- DATE PICKER ----------
            Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            InkWell(
              onTap: pickDate,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  selectedDate == null
                      ? "Choose Date"
                      : DateFormat('yyyy-MM-dd').format(selectedDate!),
                ),
              ),
            ),

            SizedBox(height: 20),

            // ---------- AMOUNT INPUT ----------
            Text("Amount", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter amount",
              ),
            ),

            Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter description",
              ),
            ),

            SizedBox(height: 20),

            // ---------- RADIO BUTTONS ----------
            // Text("Payment Method", style: TextStyle(fontWeight: FontWeight.bold)),
            // Row(
            //   children: [
            //     Radio(
            //       value: "amount",
            //       groupValue: paymentMethod,
            //       onChanged: (val) {
            //         setState(() {
            //           paymentMethod = val.toString();
            //           showQr = false;
            //         });
            //       },
            //     ),
            //     Text("Amount"),
            //
            //     Radio(
            //       value: "wallet",
            //       groupValue: paymentMethod,
            //       onChanged: (val) {
            //         setState(() {
            //           paymentMethod = val.toString();
            //           showQr = true; // show QR
            //         });
            //
            //         BlocProvider.of<ExpenseBloc>(context).add(
            //             FetchQR()
            //         );
            //       },
            //     ),
            //     Text("Wallet"),
            //   ],
            // ),

            // ---------- SHOW QR IF SELECTED ----------
            // if (showQr)
            // Center(
            //     child:  BlocConsumer<ExpenseBloc, ExpenseState>(
            //       listener: (context, state) {
            //
            //         if (state is QRSuccess) {
            //
            //           if(state.qrEntity.status==1)
            //           {
            //             QrEntity dbe=state.qrEntity;
            //
            //             setState(() {
            //               data=dbe.data.toString();
            //
            //
            //
            //             });
            //
            //
            //           }
            //
            //         }
            //         else if(state is QRFailed)
            //         {
            //           setState(() {
            //             data="Failed";
            //
            //
            //
            //           });
            //
            //         }
            //         else if(state is QRLoading)
            //         {
            //           setState(() {
            //             data="Loading";
            //
            //
            //
            //           });
            //         }
            //       },
            //       builder: (context, state) {
            //
            //         if(data.compareTo("Loading")==0)
            //         {
            //           return CircularProgressIndicator();
            //
            //         }
            //         else if(data.compareTo("Failed")==0)
            //         {
            //           return Text("No data found");
            //         }
            //         else {
            //           return QrImageView(
            //             data: data, // your string here
            //             version: QrVersions.auto,
            //             size: 150.0, // size of QR
            //             backgroundColor: Colors.white,
            //           );
            //         }
            //       },
            //     )
            //
            //
            //
            //
            //
            // ),

            SizedBox(height: 40,),

            // ---------- ADD BUTTON ----------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // TODO: handle save

                  if(amountController.text.trim().isNotEmpty)
                  {
                    if(descriptionController.text.trim().isNotEmpty)
                    {

                      String dt = DateFormat("dd-MMM-yyyy hh:mm a").format(selectedDate!);




                      try {

                        AppUtils.showLoader(context);

                        Map mp=new HashMap();
                        mp["amount"]=amountController.text.trim();
                        mp["description"]=descriptionController.text.trim();
                        mp["date"]=dt;


                        final response =
                        await WebCallRepository.post(mp,APICredentials.addExpense);


                        AppUtils.hideLoader(context);
                        if (response["status"] == 1) {


                          AppUtils.showAlert(context, response["message"]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Added expense Successfully")),
                          );

                        } else {


                          AppUtils.showAlert(context, response["message"] ?? " failed");
                        }
                      } catch (e) {
                        AppUtils.showAlert(context, e.toString());
                      }



                    }
                    else{


                      AppUtils.showAlert(context, "Enter description");
                    }

                  }
                  else{


                    AppUtils.showAlert(context, "Enter amount");
                  }


                },
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text("Add Expense"),
                ),
              ),
            )
          ],
        ),
      )






    );
  }





}
