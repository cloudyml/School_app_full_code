import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';

class CategoryData {
  final String image;
  final String name;
  final Widget screen;

  CategoryData({required this.image, required this.name, required this.screen});
}

class CategoryBox extends StatefulWidget {
  final CategoryData data;

  CategoryBox({
    required this.data,
  });

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => widget.data.screen));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: deepBlue),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3), // Offset in the Y direction
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.data.image,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.data.name,
                style: const TextStyle(
                  fontFamily: 'UbuntuMedium',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
