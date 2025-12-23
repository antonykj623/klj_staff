import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:kljcafe_staff_new/utils/apputils.dart';

import 'package:kljcafe_staff_new/widgets/qrcodescanner.dart';


import '../domain/customer_data_entity.dart';
import '../web/api_credentials.dart';
import '../web/webcallRepository.dart';
class AddIncomeScreen extends StatefulWidget {
  @override
  _AddIncomeScreenState createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController walletamountCtrl = TextEditingController();
  final TextEditingController customerCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  DateTime? selectedDate;
  String id="0";

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dateCtrl.text = DateFormat("dd/MM/yyyy").format(picked);
      });
    }
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomerDetailsDialog(BuildContext context, Map<String, dynamic> response) {
    final data = response["data"];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text("Customer Details", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow("ID", "kljcafe_"+data["id"]),
              _buildRow("Name", data["name"]),
              _buildRow("Mobile", data["mobile"]),
              // _buildRow("User Type", data["usertype"]),
              // _buildRow("Status", data["status"]),
             // _buildRow("Created Date", data["created_date"]),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () { Navigator.pop(context);

                setState(() {
                  customerCtrl.text=data["name"];
                  id=data["id"];
                });

                },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

      selectedDate = DateTime.now();
      dateCtrl.text = DateFormat("dd/MM/yyyy").format(selectedDate!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text("Add Income",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // ---- DATE FIELD ----
            buildStyledField(
              label: "Date",
              controller: dateCtrl,
              icon: Icons.calendar_month,
              readOnly: true,
              onTap: pickDate,
            ),
            SizedBox(height: 18),

            // ---- AMOUNT FIELD ----
            buildStyledField(
              label: "Amount",
              controller: amountCtrl,
              icon: Icons.currency_rupee,
              keyboard: TextInputType.number,
            ),
            SizedBox(height: 18),
            buildStyledField(
              label: "Customer's sent Wallet Amount",
              controller: walletamountCtrl,
              icon: Icons.currency_rupee,
              keyboard: TextInputType.number,
            ),
            SizedBox(height: 18),
            buildStyledField(
              label: "Description",
              maxlines: 4,
              controller: descriptionCtrl,
              icon: Icons.list_alt,
              keyboard: TextInputType.text,

            ),
            SizedBox(height: 18),


            // ---- SELECT CUSTOMER BUTTON ----
            GestureDetector(
              onTap: () => showCustomerSelectionDialog(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      customerCtrl.text.isEmpty
                          ? "Select Customer (if exists)"
                          : customerCtrl.text,
                      style: TextStyle(
                        fontSize: 16,
                        color: customerCtrl.text.isEmpty
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                    Icon(Icons.person_search, color: Colors.blueAccent),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            // ---- ADD BUTTON ----
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () async {
                  // TODO: Add income logic here

                  if(dateCtrl.text.trim().isNotEmpty)
                  {
                    if(amountCtrl.text.trim().isNotEmpty)
                    {

                      if(walletamountCtrl.text.trim().isNotEmpty) {
                        if (descriptionCtrl.text
                            .trim()
                            .isNotEmpty) {





                          try {
                            AppUtils.showLoader(context);
                            // $amount=$_POST['amount'];
                            // $wallet_amount=$_POST['wallet_amount'];
                            // $description=$_POST['description'];
                            // $entered_date=$_POST['date'];
                            // $userid_toSendwalletamount=$_POST['userid_toSendwalletamount'];

                            Map mp=new HashMap();
                            mp["userid_toSendwalletamount"]=id;
                            mp["date"]=dateCtrl.text;
                            mp["description"]=descriptionCtrl.text;
                            mp["wallet_amount"]=walletamountCtrl.text.trim();
                            mp["amount"]=amountCtrl.text.trim();





                            final response =
                            await WebCallRepository.post(mp,APICredentials.addIncome);

                            AppUtils.hideLoader(context);

                            if (response["status"] == 1) {
                              setState(() {
                                selectedDate = DateTime.now();
                                dateCtrl.text = DateFormat("dd/MM/yyyy").format(selectedDate!);
                                amountCtrl.clear();
                                descriptionCtrl.clear();
                                walletamountCtrl.clear();
                                id="0";
                                customerCtrl.clear();

                              });

                              AppUtils.showAlert(
                                  context, "Income added successfully");
                            } else {


                              AppUtils.showAlert(
                                  context, response["message"] ?? " failed");
                            }
                          } catch (e) {
                            AppUtils.showAlert(
                                context, e.toString());
                          }


                        }
                        else {
                          AppUtils.showAlert(
                              context, "Enter the description");
                        }
                      }
                      else{
                        AppUtils.showAlert(
                            context, "Enter the wallet amount");

                      }
                    }
                    else{

                      AppUtils.showAlert(context, "Enter the amount");
                    }
                  }
                  else{

                    AppUtils.showAlert(context, "Select Date");
                  }


                },
                child: Text(
                  "Add Income",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      )




    );
  }

  // -----------------------------------------------------
  // BEAUTIFUL STYLED TEXTFIELD WIDGET
  // -----------------------------------------------------
  Widget buildStyledField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool readOnly = false,
    int maxlines=1,
    TextInputType keyboard = TextInputType.text,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        maxLines: 1,
        keyboardType: keyboard,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
      ),
    );
  }

  // -----------------------------------------------------
  // STYLED DIALOG FOR CUSTOMER SELECTION
  // -----------------------------------------------------
  void showCustomerSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Customer",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                SizedBox(height: 20),

                // Buttons
                ElevatedButton.icon(
                  icon: Icon(Icons.phone_android),
                  style: dialogBtnStyle(),
                  onPressed: () async {

                    // TODO: Search by mobile
                    Navigator.pop(context);

                   showMobileSearchDialog(context);




                  },
                  label: Text("Search by Mobile"),
                ),
                SizedBox(height: 10),

                ElevatedButton.icon(
                  icon: Icon(Icons.qr_code_scanner),
                  style: dialogBtnStyle(),
                  onPressed: () async {

                    // TODO: Search by QR


                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MobileScannerPage(),
                        ),
                      );

                      if (result != null) {
                        print("QR RESULT: $result");


                        Navigator.pop(context);
                        try {
                  AppUtils.showLoader(context);





                          final response =
                          await WebCallRepository.get(APICredentials.decryptQRToken+"?qrtoken="+result);
AppUtils.hideLoader(context);

                          if (response["status"] == 1) {
                            CustomerDataEntity customerDataEntity=CustomerDataEntity.fromJson(response);


                            showCustomerDetailsDialog(context, customerDataEntity.toJson());


                          } else {


                            AppUtils.showAlert(context, response["message"] ?? " failed");
                          }
                        } catch (e) {
                          AppUtils.showAlert(context, e.toString());
                        }


                      }


                  },
                  label: Text("Search by QR"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


   showMobileSearchDialog(BuildContext context) {
    TextEditingController mobileCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text("Search Customer"),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // Mobile Input Field
              TextField(
                controller: mobileCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Enter Mobile Number",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      String mobile = mobileCtrl.text.trim();

                      if(mobile.isNotEmpty) {
                        // BlocProvider.of<IncomeBloc>(context).add(
                        //     FetchCustomerByID(mobile)
                        // );

                        try {
                        AppUtils.showLoader(context);




                          final response =
                              await WebCallRepository.get(APICredentials.getCustomerDetailsByMobile+"?mobile="+mobile);

                          AppUtils.hideLoader(context);

                          if (response["status"] == 1) {
                            CustomerDataEntity loginResponseEntity=CustomerDataEntity.fromJson(response);

                            showCustomerDetailsDialog(context, loginResponseEntity.toJson());




                          } else {


                            AppUtils.showAlert(context, response["message"] ?? " failed");
                          }
                        } catch (e) {

                          AppUtils.showAlert(context, e.toString());


                        }





                      }
                      // return value
                    },
                    child: Text("Search"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }


  ButtonStyle dialogBtnStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    );
  }

  void openCustomerSearchDialog() {
    TextEditingController mobileController = TextEditingController();
    Map<String, dynamic>? foundCustomer;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text("Search Customer"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: () {
                      String query = mobileController.text.trim();

                      // Search from list
                      // foundCustomer = customers.firstWhere(
                      //       (c) => c["mobile"] == query,
                      //   orElse: () => {},
                      // );

                      setStateSB(() {}); // Update dialog UI
                    },
                    child: Text("Search"),
                  ),

                  SizedBox(height: 10),

                  // Display Result
                  foundCustomer == null
                      ? SizedBox()
                      : foundCustomer!.isEmpty
                      ? Text(
                    "No customer found",
                    style: TextStyle(color: Colors.red),
                  )
                      : Column(
                    children: [
                      Text(
                        "Customer Found:",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text("Name: ${foundCustomer!['name']}"),
                      Text("Mobile: ${foundCustomer!['mobile']}"),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                )
              ],
            );
          },
        );
      },
    );
  }

}
