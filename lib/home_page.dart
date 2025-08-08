import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Car data
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

  int _selectedIndex = 0; // for UI highlighting

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCarCard(Map<String, dynamic> car) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(car["image"], height: 180, fit: BoxFit.contain),
          const SizedBox(height: 10),
          Text(
            car["name"],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            "Year: ${car["year"]}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            "Horsepower: ${car["hp"]}",
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            car["acceleration"],
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 5),
          Text(
            car["price"],
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.grey[800]!, width: 1)),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // just UI change
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("BMW Garage"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return _buildCarCard(cars[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}
