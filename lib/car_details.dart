import 'package:flutter/material.dart';

class CarDetails extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarDetails({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          car["name"],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Car Image with Hero Animation
            Hero(
              tag: car["name"],
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.5),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    car["image"],
                    fit: BoxFit.contain,
                    height: 250,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Car Name
            Text(
              car["name"],
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),

            // Price Tag
            Text(
              car["price"],
              style: const TextStyle(
                color: Colors.blueAccent,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Specifications Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSpecRow(Icons.calendar_today, "Year", car["year"]),
                  const Divider(color: Colors.white24, thickness: 0.5),
                  _buildSpecRow(Icons.speed, "Horsepower", car["hp"]),
                  const Divider(color: Colors.white24, thickness: 0.5),
                  _buildSpecRow(
                    Icons.flash_on,
                    "Acceleration",
                    car["acceleration"],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Call to Action Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
              ),
              onPressed: () {
                // You can add booking or contact action here
              },
              child: const Text(
                "Book a Test Drive",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
