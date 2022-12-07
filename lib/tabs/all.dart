import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/doctors.dart';
import '../screens/doctors_details_screen.dart';

class All extends StatefulWidget {
  const All({Key? key}) : super(key: key);
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  void _selectDoctor(BuildContext ctx, String id) {
    Navigator.of(ctx).pushNamed(DoctorsDetailsScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final myDoc = Provider.of<Doctors>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    final doctor = myDoc.doctors;
    return Container(
        //height: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.7,
        child: GridView.builder(
      //physics: const NeverScrollableScrollPhysics(),
      primary: false,
      //padding: const EdgeInsets.all(20),
      itemCount: doctor.length,
      itemBuilder: (ctx, i) => InkWell(
        onTap: () => _selectDoctor(context, doctor[i].id),
        splashColor: theme.primary,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
          ),
          //padding: EdgeInsets.all(0),
          child: LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.13,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.3,
                  child: FittedBox(
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                        doctor[i].imageUrl,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.07,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.09,
                  child: FittedBox(
                    child: Text(
                      '${doctor[i].firstName} ${doctor[i].abb}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.07,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.09,
                  child: FittedBox(
                    child: Text(
                      doctor[i].type,
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.07,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.08,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 15),
                        Text(
                          ' ${doctor[i].rating} (${doctor[i].reviews} reviews)',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 200,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
    ));
  }
}
