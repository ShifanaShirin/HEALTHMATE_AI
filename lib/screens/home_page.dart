import 'package:flutter/material.dart';
import 'disease_prediction.dart';
import 'medicine_recommendation.dart';
import 'expiry_tracker.dart';
import 'intake_reminder.dart';
import 'first_aid_guide.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'title': 'Disease Prediction',
        'icon': Icons.coronavirus,
        'page': const DiseasePredictionPage(),
      },
      {
        'title': 'Medicine Recommendation',
        'icon': Icons.medical_services,
        'page': const MedicineRecommendationPage(),
      },
      {
        'title': 'Expiry Tracker',
        'icon': Icons.date_range,
        'page': const ExpiryTrackerPage(),
      },
      {
        'title': 'Intake Reminder',
        'icon': Icons.alarm,
        'page': const IntakeReminderPage(),
      },
      {
        'title': 'First Aid Guide',
        'icon': Icons.health_and_safety,
        'page': FirstAidGuidePage(), // This is not const due to dynamic data inside
      },
    ];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hey 👋\nWelcome to HealthMate AI!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                itemCount: features.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => features[index]['page'],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(255, 255, 255, 0.3),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            features[index]['icon'],
                            size: 40,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            features[index]['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
