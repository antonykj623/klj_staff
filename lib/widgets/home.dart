import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kljcafe_employee/blocs/dashboard/dashboard_bloc.dart';
import 'package:kljcafe_employee/blocs/expense/expense_bloc.dart';
import 'package:kljcafe_employee/blocs/income/income_bloc.dart';
import 'package:kljcafe_employee/domain/dashboard_entity.dart';
import 'package:kljcafe_employee/domain/expense_data_entity.dart';
import 'package:kljcafe_employee/domain/income_data_entity.dart';
import 'package:kljcafe_employee/widgets/addExpense.dart';
import 'package:kljcafe_employee/widgets/addIncome.dart';

import '../utils/apputils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  double income = 0.0;
  double expense = 0.0;
  double wallet = 0.0;
  List<DashboardIncomedata>? incomedata = [];
  List<DashboardExpensedata>? expensedata = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  late TabController _tabController;
  String formatDate(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    BlocProvider.of<DashboardBloc>(context).add(
      LoadDashboard(
          formatDate(startDate),
          formatDate(endDate)
      ),
    );

  }

  // getExpenseReport()async{
  //   BlocProvider.of<ExpenseBloc>(context).add(
  //     FetchAllExpense(
  //         formatDate(startDate),
  //         formatDate(endDate)
  //     ),
  //   );
  //
  // }
  //
  // getIncomeReport()async{
  //   BlocProvider.of<IncomeBloc>(context).add(
  //     FetchAllIncome(
  //       formatDate(startDate),
  //   formatDate(endDate)
  //     ),
  //   );
  //
  // }

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

      body:  Column(
    children: [
    Expanded(
    child: ListView(
        padding: EdgeInsets.all(8),
    children: [

    // ------------- DATE PICKERS -------------
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

    // SEARCH BUTTON
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
    BlocProvider.of<DashboardBloc>(context).add(
    LoadDashboard(formatDate(startDate), formatDate(endDate)),
    );
    },
    child: const Text(
    "Search",
    style: TextStyle(fontSize: 18, color: Colors.white),
    ),
    ),
    ),

    const SizedBox(height: 20),

    // ----------- DASHBOARD CARDS (INCOME / EXPENSE) -----------
    BlocConsumer<DashboardBloc, DashboardState>(
    listener: (context, state) {
    if (state is DashboardSuccess) {
    AppUtils.hideLoader(context);

    DashboardEntity dbe = state.dashboardEntity;
    setState(() {
    income = dbe.totalIncome!.toDouble();
    expense = dbe.totalExpense!.toDouble();
    incomedata = dbe.incomedata!;
    expensedata = dbe.expensedata!;
    });
    }
    else if (state is DashboardFailed) {
    AppUtils.hideLoader(context);
    }
    else if (state is DashboardLoading) {
    AppUtils.showLoader(context);
    }
    },

    builder: (context, state) {
    return Column(
    children: [
    Row(
    children: [
    Expanded(
    child: GestureDetector(
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (_) => AddIncomeScreen())
    );
    },
    child: dashboardCard(
    title: "Income",
    amount: income,
    color: Colors.green,
    icon: Icons.arrow_upward,
    ),
    ),
    ),
    const SizedBox(width: 5),
    Expanded(
    child: GestureDetector(
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (_) => AddExpenseScreen())
    );
    },
    child: dashboardCard(
    title: "Expense",
    amount: expense,
    color: Colors.red,
    icon: Icons.arrow_downward,
    ),
    ),
    ),
    ],
    ),

    const SizedBox(height: 15),

    // -------- TABS ---------
    Container(
    height: 50,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    ),
    child:  TabBar(
      controller: _tabController,
    indicatorColor: Colors.blueAccent,
    labelColor: Colors.blueAccent,
    unselectedLabelColor: Colors.black54,
    tabs: [
    Tab(text: "Income"),
    Tab(text: "Expense"),
    ],
    ),
    ),

    SizedBox(
    height: MediaQuery.of(context).size.height * 0.55,
    child: TabBarView(
      controller: _tabController,
    children: [
    // ------- INCOME LIST --------
    ListView.builder(
    padding: EdgeInsets.all(10),
    itemCount: incomedata!.length,
    itemBuilder: (context, index) {
    final item = incomedata![index];

    String? createddate=item.createdDate;
    DateTime parsedDate = DateTime.parse(createddate!);

    String idate=parsedDate.day.toString()+"/"+parsedDate.month.toString()+"/"+parsedDate.year.toString();
    return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
    leading: CircleAvatar(
    backgroundColor: Colors.green.shade100,
    child: Icon(Icons.arrow_downward, color: Colors.green),
    ),
    title: Text(item.purpose ?? "No title"),
    subtitle: Text("Date: ${idate ?? ""}"),
    trailing: Text(
    "₹ ${item.amount ?? 0}",
    style: const TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.bold),
    ),
    ),
    );
    },
    ),

    // ------- EXPENSE LIST --------
    ListView.builder(
    padding: EdgeInsets.all(10),
    itemCount: expensedata!.length,
    itemBuilder: (context, index) {
    final item = expensedata![index];

    String? createddate=item.createdDate;
    DateTime parsedDate = DateTime.parse(createddate!);

    String idate=parsedDate.day.toString()+"/"+parsedDate.month.toString()+"/"+parsedDate.year.toString();
    return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
    leading: CircleAvatar(
    backgroundColor: Colors.red.shade100,
    child: Icon(Icons.arrow_upward, color: Colors.red),
    ),
    title: Text(item.description ?? "No title"),
    subtitle: Text("Date: ${idate ?? ""}"),
    trailing: Text(
    "₹ ${item.amount ?? 0}",
    style: const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold),
    ),
    ),
    );
    },
    ),
    ],
    ),
    ),
    ],
    );
    },
    ),
    ],
    ),
    ),
    ],
    )


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
