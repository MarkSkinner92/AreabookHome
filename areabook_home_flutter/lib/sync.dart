import 'package:flutter/material.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  bool isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Sync"),
        backgroundColor: const Color.fromARGB(255, 155, 1, 65),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const SizedBox(height: 30),

            // ------- Fake Google Sign-In Button -------
            ElevatedButton.icon(
              onPressed: () {
                // Fake sign-in action
                setState(() {
                  isSignedIn = true;
                });
              },
              label: Text(
                isSignedIn ? "Signed in with Google" : "Sign in with Google",
                style: const TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.black12),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ------- Sync Button -------
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 155, 1, 65),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Sync Now",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),

            // Status text
            Center(
              child: Text(
                isSignedIn
                    ? "You are signed in. Ready to sync."
                    : "Not signed in.",
                style: TextStyle(
                  fontSize: 16,
                  color: isSignedIn ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
