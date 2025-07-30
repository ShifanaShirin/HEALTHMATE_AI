import 'package:flutter/material.dart';

class MedicineRecommendationPage extends StatelessWidget {
  const MedicineRecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Recommendation'),
      ),
      body: const Center(
        child: Text('Medicine Recommendation Content Goes Here'),
      ),
    );
  }
}
