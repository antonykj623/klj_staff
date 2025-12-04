import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double income = 12000;
  double expense = 4500;
  double wallet = 7500;

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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: dashboardCard(
                  title: "Income",
                  amount: income,
                  color: Colors.green,
                  icon: Icons.arrow_upward,
                )),
                const SizedBox(width: 12),
                Expanded(child: dashboardCard(
                  title: "Expense",
                  amount: expense,
                  color: Colors.red,
                  icon: Icons.arrow_downward,
                )),
              ],
            ),

            const SizedBox(height: 12),

            dashboardCard(
              title: "Wallet Balance",
              amount: wallet,
              color: Colors.blue,
              icon: Icons.account_balance_wallet,
              isLarge: true,
            ),

            const SizedBox(height: 20),

            const Text(
              "Recent Transactions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return transactionTile(
                  title: "Sample Transaction ${index + 1}",
                  amount: (index + 1) * 150.50,
                  isIncome: index % 2 == 0,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // Dashboard Card Widget
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
      padding: const EdgeInsets.all(16),
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
            radius: 26,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 5),
                Text(
                  "₹ ${amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 20,
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

  // ------------------------------
  // Transaction Tile Widget
  // ------------------------------
  Widget transactionTile({
    required String title,
    required double amount,
    required bool isIncome,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          Icon(
            isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: isIncome ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            "₹ ${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              color: isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
