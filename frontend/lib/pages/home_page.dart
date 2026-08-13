import 'package:flutter/material.dart';
import 'agro_expense_page.dart';
import 'farm_expense_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Expense Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Open profile page
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome section
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            const Text(
              'Manage your farming expenses',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // -------------------------
            // ADD FARM EXPENSE
            // -------------------------
            _buildMenuCard(
              icon: Icons.agriculture_outlined,
              title: 'Add Farm Expense',
              subtitle: 'Record of Farnm Expense',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FarmExpensePage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            // -------------------------
            // ADD AGRO EXPENSE
            // -------------------------
            _buildMenuCard(
              icon: Icons.inventory_2_outlined,
              title: 'Add Agro Expense',
              subtitle: 'Record agro product purchases',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgroExpensePage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            // -------------------------
            // ADD NEW FARM / REGION
            // -------------------------
            _buildMenuCard(
              icon: Icons.add_business_outlined,
              title: 'Add New Farm / Region',
              subtitle: 'Create a new region or farm',
              onTap: () {
                // TODO:
                // Navigate to Add Region/Farm page
              },
            ),

            const SizedBox(height: 15),

            // -------------------------
            // SEE ALL TOTAL EXPENSE
            // -------------------------
            _buildMenuCard(
              icon: Icons.bar_chart_outlined,
              title: 'See All Total Farm Expense',
              subtitle: 'View expenses by region and farm',
              onTap: () {
                // TODO:
                // Navigate to Total Expense Report
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(12),

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Row(
            children: [
              // Icon
              Container(
                height: 55,
                width: 55,

                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Icon(icon, size: 30, color: Colors.green.shade700),
              ),

              const SizedBox(width: 16),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // Arrow
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
