import 'package:flutter/material.dart';
import 'package:bmw_clone/search.dart';
import 'package:bmw_clone/car_details.dart';
import 'package:bmw_clone/account.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  final VoidCallback toggleTheme;
  final bool isDarkMode;

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

  // Pages for BottomNavigationBar tabs
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeTab(),
      SearchPage(), // no parameters
      AccountPage(), // no parameters
    ];
  }

  Widget _buildHomeTab() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.9,
        ),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return _buildCarCard(cars[index]);
        },
      ),
    );
  }

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
                aspectRatio: 1.3,
                child: Hero(
                  tag: car["name"],
                  child: Image.asset(car["image"], fit: BoxFit.contain),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Titles for AppBar based on selected tab
    const titles = ['BMW Garage', 'Search', 'Account'];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
              color: Colors.white,
            ),
            tooltip: widget.isDarkMode
                ? 'Switch to Light Mode'
                : 'Switch to Dark Mode',
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
}
