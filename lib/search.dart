import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, String>> cars = [
    {
      'name': 'BMW M4',
      'image': 'assets/images/bmw-m4.png',
      'info': 'The BMW M4 is a high-performance version of the BMW 4 Series.',
    },
    {
      'name': 'BMW i8',
      'image': 'assets/images/bmw-i8.png',
      'info':
          'The BMW i8 is a plug-in hybrid sports car with futuristic design.',
    },
    {
      'name': 'BMW X6M',
      'image': 'assets/images/bmw-x6m.png',
      'info': 'The BMW X6M is a high-performance luxury crossover SUV.',
    },
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredCars = cars
        .where(
          (car) => car['name']!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Cars'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: filteredCars.isEmpty
                ? const Center(child: Text('No cars found'))
                : ListView.builder(
                    itemCount: filteredCars.length,
                    itemBuilder: (context, index) {
                      final car = filteredCars[index];
                      return ListTile(
                        leading: Image.asset(
                          car['image']!,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        title: Text(car['name']!),
                        subtitle: Text(car['info']!),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailPage(
                                name: car['name']!,
                                image: car['image']!,
                                info: car['info']!,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CarDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String info;

  const CarDetailPage({
    super.key,
    required this.name,
    required this.image,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(image, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              info,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
