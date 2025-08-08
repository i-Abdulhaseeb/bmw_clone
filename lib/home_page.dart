import 'package:flutter/material.dart';
import 'package:bmw_clone/search.dart';
import 'package:bmw_clone/car_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> cars = [
    {
      "name": "BMW M4 Coupe",
      "year": "2024",
      "hp": "503 HP",
      "acceleration": "0-60 mph: 3.8 sec",
      "price": "\$78,100",
      "image": "assets/images/bmw-m4.png",
    },
    {
      "name": "BMW i8",
      "year": "2020",
      "hp": "369 HP",
      "acceleration": "0-60 mph: 4.2 sec",
      "price": "\$147,500",
      "image": "assets/images/bmw-i8.png",
    },
    {
      "name": "BMW X6 M",
      "year": "2023",
      "hp": "600 HP",
      "acceleration": "0-60 mph: 3.7 sec",
      "price": "\$113,700",
      "image": "assets/images/bmw-x6m.png",
    },
  ];

  int _selectedIndex = 0;

  Widget _buildCarCard(Map<String, dynamic> car) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarDetails(car: car)),
        );
      },
      child: Card(
        color: Colors.grey[900],
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: AspectRatio(
                aspectRatio: 1.3, // keeps image proportion consistent
                child: Hero(
                  tag: car["name"],
                  child: Image.asset(
                    car["image"],
                    fit: BoxFit.contain, // shows full car without cutting
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              child: Text(
                car["name"],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.white54,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() => _selectedIndex = index);

        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Account",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("BMW Garage"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9, // balanced card shape
          ),
          itemCount: cars.length,
          itemBuilder: (context, index) {
            return _buildCarCard(cars[index]);
          },
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}
