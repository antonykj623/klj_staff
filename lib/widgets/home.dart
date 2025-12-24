import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:kljcafe_staff_new/domain/app_update_entity.dart';
import 'package:kljcafe_staff_new/domain/dashboard_entity.dart';
import 'package:kljcafe_staff_new/domain/expense_data_entity.dart';
import 'package:kljcafe_staff_new/domain/income_data_entity.dart';
import 'package:kljcafe_staff_new/widgets/addExpense.dart';
import 'package:kljcafe_staff_new/widgets/addIncome.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../domain/qr_entity.dart';
import '../prefdata/sharedpref.dart';
import '../utils/apputils.dart';
import '../web/api_credentials.dart';
import '../web/webcallRepository.dart';
import 'login.dart';

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

  String name="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDashboardData();
    });



  }

  getDashboardData()async
  {
    try {

      AppUtils.showLoader(context);


      Map mp=new HashMap();
      mp["start_date"]=formatDate(startDate);
      mp["end_date"]=formatDate(endDate);

      final response =
      await WebCallRepository.post(mp, APICredentials.getAllTransactions);

      AppUtils.hideLoader(context);

      if (response["status"] == 1) {
        DashboardEntity dbe=DashboardEntity.fromJson(response);

        setState(() {
          income = dbe.totalIncome!.toDouble();
          expense = dbe.totalExpense!.toDouble();
          incomedata = dbe.incomedata!;
          expensedata = dbe.expensedata!;
        });



      } else {


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response["message"] ?? " failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  getName()async
  {


    String? na=  await SharedPref.getString(APICredentials.name);

    setState(() {
      name=na!;
    });
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



  void showQrDialog(BuildContext context, String data) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Scan QR Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                QrImageView(
                  data: data,
                  size: 200,
                  backgroundColor: Colors.white,
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                )
              ],
            ),
          ),
        );
      },
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
        title:  Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),

        actions: [

      Padding(
      padding: const EdgeInsets.all(10),
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.settings, size: 25),
        onSelected: (value) async {
          if(value=='appupdate')
          {
            // BlocProvider.of<AccountBloc>(context).add(
            //   AppupdateAccount(
            //   ),
            // );

            try {
              AppUtils.showLoader(context);




              final response =
              await WebCallRepository.get( APICredentials.getAppupdate);

              AppUtils.hideLoader(context);

              if (response["status"] == 1) {

                AppUpdateEntity appupdateentity=AppUpdateEntity.fromJson(response);


                double version=0.0;
                double versionfromserver=0.0;
                String updateurl="";

                if(appupdateentity.status==1)
                {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();

                  String appName = packageInfo.appName;
                  String packageName = packageInfo.packageName;
                  String v = packageInfo.version;        // e.g. 1.0.3
                  String buildNumber = packageInfo.buildNumber; // e.g. 12

                  for(AppUpdateData appupdate in appupdateentity.data!)
                  {

                    if(appupdate.mobileApp.toString().trim().compareTo(packageName)==0)
                    {

                      version=double.parse(buildNumber);
                      versionfromserver=double.parse(appupdate.version.toString());
                      updateurl=appupdate.url.toString();

                      break;

                    }

                  }

                  if(versionfromserver>version)
                  {

                    bool? result = await AppUtils.showYesNoDialog(
                      context,
                      "App update",
                      "You should update mobile app.Do you want to update now ?",
                    );

                    if (result == true) {

                      final Uri url = Uri.parse(updateurl); // Change URL based on platform

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      } else {
                        throw "Could not launch $url";
                      }


                    }
                  }
                  else{
                    AppUtils.showSingleButtonAlert(context, "App update", "No updates available");

                  }

                }
              } else {


                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response["message"] ?? " failed")),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
          }
          else if (value == 'delete') {

            bool? result = await AppUtils.showYesNoDialog(
              context,
              "Delete Account",
              "Are you sure you want to delete account ?",
            );

            if (result == true) {


              try {
                AppUtils.showLoader(context);

                final response =
                await WebCallRepository.get( APICredentials.deleteEmployee);
                AppUtils.hideLoader(context);

                if (response["status"] == 1) {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Account Deleted successfully")),
                  );


                  SharedPref.setString(APICredentials.apptoken,"");

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response["message"] ?? " failed")),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }

            }


          }
          else if (value == 'logout') {

            bool? result = await AppUtils.showYesNoDialog(
              context,
              "Logout",
              "Are you sure you want to logout ?",
            );

            if (result == true) {
              // delete logic



              SharedPref.setString(APICredentials.apptoken,"");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          }
          else if(value == 'qrcode')
            {


              try {

               AppUtils.showLoader(context);

                Map mp=new HashMap();


                final response =
                await WebCallRepository.post(mp,APICredentials.generateQRToken);

                AppUtils.hideLoader(context);

                if (response["status"] == 1) {
                  QrEntity loginResponseEntity=QrEntity.fromJson(response);


                  showQrDialog(context, loginResponseEntity.data.toString());

                } else {


                  AppUtils.showAlert(context, response["message"] ?? " failed");
                }
              } catch (e) {
                AppUtils.showAlert(context, e.toString());
              }





            }
        },
        itemBuilder: (BuildContext context) => [

          const PopupMenuItem(
            value: 'qrcode',
            child: Text('QR code'),
          ),
          const PopupMenuItem(
            value: 'appupdate',
            child: Text('App update'),
          ),

          const PopupMenuItem(
            value: 'logout',
            child: Text('Logout'),
          ),

          const PopupMenuItem(
            value: 'delete',
            child: Text('Delete Account'),
          ),
        ],
      ),
    )







        ],



      ),

      body:  DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [

                /// -------- DATE PICKERS ----------
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: pickStartDate,
                            child: dateCard(
                              "Start Date",
                              formatDate(startDate),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: pickEndDate,
                            child: dateCard(
                              "End Date",
                              formatDate(endDate),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// -------- SEARCH BUTTON ----------
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2575FC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: getDashboardData,
                        child: const Text(
                          "Search",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                /// -------- DASHBOARD CARDS ----------
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => AddIncomeScreen()),
                              );
                            },
                            child: dashboardCard(
                              title: "Income",
                              amount: income,
                              color: Colors.green,
                              icon: Icons.arrow_downward,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => AddExpenseScreen()),
                              );
                            },
                            child: dashboardCard(
                              title: "Expense",
                              amount: expense,
                              color: Colors.red,
                              icon: Icons.arrow_upward,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// -------- TAB BAR ----------
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TabBar(
                        indicatorColor: Colors.blueAccent,
                        labelColor: Colors.blueAccent,
                        unselectedLabelColor: Colors.black54,
                        tabs: [
                          Tab(text: "Income"),
                          Tab(text: "Expense"),
                        ],
                      ),
                    ),
                  ),
                ),

                /// -------- TAB CONTENT ----------
                SliverFillRemaining(
                  child: TabBarView(
                    children: [

                      /// -------- INCOME LIST ----------
                      incomedata != null && incomedata!.isNotEmpty
                          ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: incomedata!.length,
                        itemBuilder: (context, index) {
                          final item = incomedata![index];
                          return _transactionTile(
                            title: item.description ?? "No title",
                            date: item.createdDate ?? "",
                            amount: item.amount.toString(),
                            color: Colors.green,
                            icon: Icons.arrow_downward,
                          );
                        },
                      )
                          : const Center(child: Text("No income data")),

                      /// -------- EXPENSE LIST ----------
                      expensedata != null && expensedata!.isNotEmpty
                          ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: expensedata!.length,
                        itemBuilder: (context, index) {
                          final item = expensedata![index];
                          return _transactionTile(
                            title: item.description ?? "No title",
                            date: item.createdDate ?? "",
                            amount: item!.amount.toString(),
                            color: Colors.red,
                            icon: Icons.arrow_upward,
                          );
                        },
                      )
                          : const Center(child: Text("No expense data")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )



    );
  }

  Widget _transactionTile({
    required String title,
    required String date,
    required String amount,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text("Date: $date"),
        trailing: Text(
          "₹ $amount",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
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
