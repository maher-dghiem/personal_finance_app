import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_app/data/models/transaction.dart';

class SummaryScreenPage extends StatelessWidget {
  final List<Transaction> transactions;
  const SummaryScreenPage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Total Expenses
    double totalExpenses = transactions.fold(0, (sum, tx) => sum += tx.amount);

    // Category Breakdown
    Map<String, double> categoryTotal = {};
    for (var tx in transactions) {
      categoryTotal[tx.category] = categoryTotal[tx.category]?? 0 + tx.amount;
    }

    // Monthly Breakdown
    final Map<String, double> monthlyTotal = {};
    for (var tx in transactions) {
      final month = DateFormat('MMM yyyy').format(tx.date);
      monthlyTotal[month] = (monthlyTotal[month] ?? 0) + tx.amount;}

    // Biggest Expense
    final biggestExpense = transactions.isNotEmpty? transactions.reduce((a, b) => a.amount >= b.amount? a : b) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text("Summary",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,),),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                // Breakdown Section
                Text('Total Expenses: \$${totalExpenses.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,),),
                SizedBox(height: 20),
                Text('Category Breakdown',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,),),
                ...categoryTotal.entries.map((entry) => Text(
                    '${entry.key}: \$${entry.value.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,),)),
                SizedBox(height: 20),
                Text('Monthly Breakdown',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,),),
                ...monthlyTotal.entries.map((entry) => Text(
                    '${entry.key}: \$${entry.value.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,),)),
                SizedBox(height: 20),
                if (biggestExpense != null)
                  Text('Biggest Expense: ${biggestExpense.title} — \$${biggestExpense.amount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,),),

                //  Pie Chart
                SizedBox(height: 30),
                Container(
                  height: 270,
                  child: PieChart(PieChartData(
                    sections: categoryTotal.entries.map((entry) =>
                        PieChartSectionData(
                          value: entry.value,
                          title: entry.key,
                          color: getColorForCategory(entry.key),
                          radius: 50,
                          titleStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,),
                        ),
                    ).toList(),
                  )),
                ),

                // Bar Chart
                SizedBox(height: 30),
                Container(
                  height: 250,
                  child: BarChart(
                    BarChartData(
                      barGroups: monthlyTotal.entries.map((entry) {
                        final month = entry.key;
                        final value = entry.value;
                        return BarChartGroupData(
                          x: monthlyTotal.keys.toList().indexOf(month),
                          barRods: [
                            BarChartRodData(
                              toY: value,
                              color: Colors.teal,
                              width: 16,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        );
                      }).toList(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              final label = monthlyTotal.keys.elementAt(index);
                              return Text(label, style: TextStyle(fontSize: 10));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  getColorForCategory(String key) {
    switch (key) {
      case "General":
        return Colors.blue;
      case "Food":
        return Colors.green;
      case "Transport":
        return Colors.red;
      case "Shopping":
        return Colors.orange;
      case "Bills":
        return Colors.purple;
      case "Entertainment":
        return Colors.pink;
      case "Health":
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}
