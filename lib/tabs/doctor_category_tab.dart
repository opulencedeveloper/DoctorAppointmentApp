import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/doctor_category.dart';

class DoctorCategoryTab extends StatelessWidget {
  const DoctorCategoryTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final categoryData = Provider.of<DoctorsCategories>(context, listen: false);
    final catData = categoryData.category;

    final dynamic appBar = AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        "Categories",
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
          child: ListView.builder(
            itemCount: catData.length,
            itemBuilder: (context, i) => Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    13,
                  ),
                ),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 20),
                Text(catData[i].type, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Text(catData[i].description, style: const TextStyle(fontSize: 15)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
