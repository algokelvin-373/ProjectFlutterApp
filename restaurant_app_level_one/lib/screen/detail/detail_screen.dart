import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Food Image
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/400x300'), // Replace with actual image URL
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          // Food Details
          Positioned(
            top: MediaQuery.of(context).size.height * 0.40,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Name and Counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pan Grilled Bratwurst',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.remove_circle_outline, color: Colors.white),
                          ),
                          Text(
                            '2',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add_circle_outline, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '54 Summit Street.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 15),
                  // Rating, Time, Calories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconText(icon: Icons.star, label: '4.5'),
                      IconText(icon: Icons.access_time, label: '8-10 min'),
                      IconText(icon: Icons.local_fire_department, label: '124 Kcal'),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Nutritional Info
                  Text(
                    'Protein-50gm, Carbs-10gm, Fats-15gm\n(The unique recipe will make you fly in creaminess of cheeseburger)',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Customize >',
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 16),
                  ),
                  SizedBox(height: 25),
                  // Total and Add to Cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total amount',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        '\$30.00',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      ),
                      child: Text(
                        'Add to cart',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable IconText Widget
class IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  IconText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.orangeAccent),
        SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}