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
        'page': FirstAidGuidePage(),
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 182, 208, 243),
          automaticallyImplyLeading: false,
          title: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'HealthMate AI!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          leading: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.deepPurple),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color.fromARGB(255, 182, 208, 243)),
              accountName: const Text('Shifana'),
              accountEmail: const Text('shifana@gmail.com'),
              currentAccountPicture: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
            ),
            ListTile(
              leading: const Icon(Icons.coronavirus),
              title: const Text('Disease Prediction'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DiseasePredictionPage())),
            ),
            ListTile(
              leading: const Icon(Icons.medical_services),
              title: const Text('Medicine Recommendation'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicineRecommendationPage())),
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('Expiry Tracker'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.alarm),
              title: const Text('Intake Reminder'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.health_and_safety),
              title: const Text('First Aid Guide'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
                      content: const Text('Are you want exit this app?', style: TextStyle(fontSize: 15)),
                      actions: <Widget>[
                        ElevatedButton(
                          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 182, 208, 243))),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('CANCEL', style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 182, 208, 243))),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
                          child: const Text('OK', style: TextStyle(color: Colors.white)),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 182, 208, 243),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.center,
                children: features.map((feature) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => feature['page'],
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      height: 190,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 182, 208, 243),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            feature['icon'],
                            size: 40,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            feature['title'],
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
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
