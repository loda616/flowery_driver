import 'package:flutter/material.dart';

import 'metric_card.dart';

class MetricsDashboard extends StatelessWidget {
  const MetricsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MetricCard(
            number: "4",
            label: "Cancelled",
            icon: Icons.cancel_outlined,
            iconColor: Colors.red,
          ),
          MetricCard(
            number: "100",
            label: "Completed",
            icon: Icons.check_circle_outline,
            iconColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
