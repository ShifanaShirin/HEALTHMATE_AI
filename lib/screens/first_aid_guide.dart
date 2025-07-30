import 'package:flutter/material.dart';

class FirstAidGuidePage extends StatelessWidget {
  FirstAidGuidePage({super.key});

  final List<Map<String, String>> firstAidTips = [
    {
      'title': 'Burns',
      'tip': 'Cool the burn under running water for 10-20 minutes. Do not apply ice or butter. Cover with a clean cloth.'
    },
    {
      'title': 'Cuts & Wounds',
      'tip': 'Apply pressure to stop bleeding. Clean the wound with water. Cover with a sterile bandage.'
    },
    {
      'title': 'Choking',
      'tip': 'Encourage coughing. If the person cannot breathe, perform abdominal thrusts (Heimlich maneuver).'
    },
    {
      'title': 'Nosebleeds',
      'tip': 'Lean forward and pinch the nose. Breathe through the mouth. Hold for 10-15 minutes.'
    },
    {
      'title': 'Fainting',
      'tip': 'Lay the person flat, elevate legs, and loosen tight clothing. Check for breathing.'
    },
    {
      'title': 'Snake Bite',
      'tip': 'Keep the person calm and still. Do not suck the venom. Seek medical help immediately.'
    },
  ];

  void _showTipDialog(BuildContext context, String title, String tip) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(tip),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CLOSE"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("First Aid Guide")),
      body: ListView.builder(
        itemCount: firstAidTips.length,
        itemBuilder: (context, index) {
          final item = firstAidTips[index];
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.deepPurple.shade50,
            child: ListTile(
              leading: const Icon(Icons.health_and_safety, color: Colors.deepPurple),
              title: Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () => _showTipDialog(context, item['title']!, item['tip']!),
            ),
          );
        },
      ),
    );
  }
}
