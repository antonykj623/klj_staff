import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kljcafe_employee/blocs/expense/expense_bloc.dart';
import 'package:kljcafe_employee/blocs/income/income_bloc.dart';
import 'package:kljcafe_employee/domain/expense_data_entity.dart';
import 'package:kljcafe_employee/domain/income_data_entity.dart';

import '../utils/apputils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double income = 0.0;
  double expense = 0.0;
  double wallet = 0.0;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  String formatDate(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIncomeReport();
    getExpenseReport();
  }

  getExpenseReport()async{
    BlocProvider.of<ExpenseBloc>(context).add(
      FetchAllExpense(
          formatDate(startDate),
          formatDate(endDate)
      ),
    );

  }

  getIncomeReport()async{
    BlocProvider.of<IncomeBloc>(context).add(
      FetchAllIncome(
        formatDate(startDate),
    formatDate(endDate)
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [

            // -------------------------
            // START & END DATE PICKERS
            // -------------------------
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => pickStartDate(),
                    child: dateCard("Start Date", formatDate(startDate)),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () => pickEndDate(),
                    child: dateCard("End Date", formatDate(endDate)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),


            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2575FC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {

                  getIncomeReport();
                  getExpenseReport();

                },
                child:  const Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------
            // DASHBOARD CARDS
            // -------------------------
            Row(
              children: [
                Expanded(child: BlocConsumer<IncomeBloc, IncomeState>(
    listener: (context, state) {
    if (state is IncomeReportSuccess) {

   // AppUtils.hideLoader(context);


    IncomeDataEntity loginresponse=state.loginResponseEntity;

    if(loginresponse.status==1)
    {
      List<IncomeDataData> data =loginresponse.data!;
      income=0;

      setState(() {
        for(IncomeDataData d in data)
        {
          double amount=double.parse(d.amount.toString());
          income=income+amount;
        }
      });



    }



    }
    else if(state is IncomeReportLoading)
    {

   // AppUtils.showLoader(context);
    }




    else if (state is IncomeReportFailed) {
      //AppUtils.showLoader(context);
    }
    },
    builder: (context, state) {
    return

    dashboardCard(
    title: "Income",
    amount: income,
    color: Colors.green,
    icon: Icons.arrow_upward,
    );
    })

                ),
                const SizedBox(width: 5),


                Expanded(child:
    BlocConsumer<ExpenseBloc, ExpenseState>(
    listener: (context, state) {
    if (state is ExpenseReportSuccess) {

    // AppUtils.hideLoader(context);


    ExpenseDataEntity loginresponse=state.loginResponseEntity;

    if(loginresponse.status==1)
    {
    List<ExpenseDataData> data =loginresponse.data!;


    setState(() {
      expense=0;
    for(ExpenseDataData d in data)
    {
    double amount=double.parse(d.amount.toString());
    expense=expense+amount;
    }
    });



    }



    }





    else if (state is ExpenseReportFailed) {
    //AppUtils.showLoader(context);
    }
    },
    builder: (context, state) {
    return


    dashboardCard(
    title: "Expense",
    amount: expense,
    color: Colors.red,
    icon: Icons.arrow_downward,
    );
    })


    ),
              ],
            ),

            const SizedBox(height: 5),



            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // -------------------------
  // DATE CARD WIDGET
  // -------------------------
  Widget dateCard(String title, String dateText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.date_range, color: Colors.blueAccent),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.black54, fontSize: 12)),
                const SizedBox(height: 5),
                Text(
                  dateText,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ],
      ),
    );
  }

  // -------------------------
  // START DATE PICKER
  // -------------------------
  Future<void> pickStartDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        startDate = picked;

        // Ensure end date is never before start date
        if (endDate.isBefore(startDate)) {
          endDate = startDate;
        }
      });
    }
  }

  // -------------------------
  // END DATE PICKER
  // -------------------------
  Future<void> pickEndDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: startDate, // can't pick before start date
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  // ------------------------------
  // Dashboard Card
  // ------------------------------
  Widget dashboardCard({
    required String title,
    required double amount,
    required Color color,
    required IconData icon,
    bool isLarge = false,
  }) {
    return Container(
      height: isLarge ? 120 : 100,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 15),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style:
                    const TextStyle(fontSize: 13, color: Colors.black54)),
                const SizedBox(height: 5),
                Text(
                  "₹ ${amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 15,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
