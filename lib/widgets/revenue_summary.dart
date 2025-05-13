import 'package:flutter/material.dart';
import 'package:freshkart_admin/model/summary_model.dart';
import 'package:freshkart_admin/services/dashboard_services.dart';

class RevenueSummarySection extends StatefulWidget {
  const RevenueSummarySection({super.key});

  @override
  State<RevenueSummarySection> createState() => _RevenueSummarySectionState();
}

class _RevenueSummarySectionState extends State<RevenueSummarySection> {
  final dashboardServices = DashboardServices();
  String selectedFilter = "Today";
  SummaryModel? summary;

  final List<String> filters = [
    "Today",
    "This Week",
    "This Month",
    "This Year",
  ];
  @override
  void initState() {
    super.initState();
    fetchInitialRevenue();
  }

  fetchInitialRevenue() async {
    summary = await dashboardServices.getTodayRevenue();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Revenue Summary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (c, indx) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final filter = filters[index];
              final isSelected = selectedFilter == filter;
              return GestureDetector(
                onTap: () async {
                  setState(() {
                    selectedFilter = filter;
                    summary = null;
                  });

                  summary = await fetchSummary(index);

                  setState(() {});
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 15),

        summary == null
            ? SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            )
            : summaryContainer(summary!),
      ],
    );
  }

  Widget buildSummaryTile(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(
            '$value',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  summaryContainer(SummaryModel summary) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          buildSummaryTile("Total Orders", summary.orders),
          Divider(),
          buildSummaryTile("Revenue", summary.revenue),
          Divider(),
          buildSummaryTile("Products Sold", summary.products),
        ],
      ),
    );
  }

  Future<SummaryModel?> fetchSummary(int index) async {
    switch (index) {
      case 0:
        return await dashboardServices.getTodayRevenue();
      case 1:
        return await dashboardServices.getThisWeekSummary();
      case 2:
        return await dashboardServices.getThisMonthSummary();
      case 3:
        return await dashboardServices.getThisYearSummary();
      default:
        return null;
    }
  }
}
