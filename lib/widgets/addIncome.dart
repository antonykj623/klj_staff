import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddIncomeScreen extends StatefulWidget {
  @override
  _AddIncomeScreenState createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController customerCtrl = TextEditingController();

  DateTime? selectedDate;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text("Add Income"),
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
                          ? "Select Customer"
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
                onPressed: () {
                  // TODO: Add income logic here
                },
                child: Text(
                  "Add Income",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
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
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Search by mobile
                  },
                  label: Text("Search by Mobile"),
                ),
                SizedBox(height: 10),

                ElevatedButton.icon(
                  icon: Icon(Icons.qr_code_scanner),
                  style: dialogBtnStyle(),
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Search by QR
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

  ButtonStyle dialogBtnStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    );
  }
}
