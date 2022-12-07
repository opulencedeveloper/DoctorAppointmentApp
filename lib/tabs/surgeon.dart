import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/doctors.dart';
import '../screens/doctors_details_screen.dart';

class Surgeon extends StatelessWidget {
  const Surgeon({Key? key}) : super(key: key);
  void _selectDoctor(BuildContext ctx, String id) {
    Navigator.of(ctx).pushNamed(DoctorsDetailsScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final _myDocType = Provider.of<Doctors>(context, listen: false).findDocType("Surgeon");
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    return SizedBox(
      height: (mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight) * 0.75,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        //padding: const EdgeInsets.all(20),
        itemCount: _myDocType.length,
        itemBuilder: (ctx, i) => InkWell(
          onTap: () => _selectDoctor(context, _myDocType[i].id),
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
                          _myDocType[i].imageUrl,
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
                        '${_myDocType[i].firstName} ${_myDocType[i].abb}',
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
                        _myDocType[i].type,
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
                            ' ${_myDocType[i].rating} (${_myDocType[i].reviews} reviews)',
                            style: const TextStyle(color: Colors.grey),
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
      ),
    );
  }
}
