import 'package:flutter/material.dart';

import '../screens/summary_screen.dart';

class CreditCardScreen extends StatefulWidget {
  static const routeName = '/card-route-name';
  const CreditCardScreen({Key? key}) : super(key: key);
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  var _loadedInitData = false;
  DateTime? _selectedDate;
  var _doctorId = '';
  var time = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _doctorId = routeArgs['id'] as String;
      _selectedDate = routeArgs['date'] as DateTime;
      time = routeArgs['time'] as String;
      print('need route');
    }
    _loadedInitData = true;
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _cardNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _dateController = TextEditingController();
  final _cvvController = TextEditingController();
  bool? checkedValue = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    final dynamic appBar = AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 3,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      10,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: mediaQuery.size.width * 0.18),
            const Text(
              "Add New Card",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: Container(
        color: theme.primary,
        height: 50,
        //margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
        child: TextButton(
          child: const Text(
            "Proceed",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            _cardNameController.clear();
            _cardNumberController.clear();
            _dateController.clear();
            _cvvController.clear();
            Navigator.of(context).pushNamed(
              SummaryScreen.routeName,
              arguments: {
                'id': _doctorId,
                'date': _selectedDate,
                'time': time,
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/card.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Card Name',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _cardNameController,
                    decoration: InputDecoration(
                      //labelText: 'XXXX XXX XXXX XXXX',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      // filled: true,
                      // fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        //color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Card Number',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'XXXX XXX XXXX XXXX',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      // filled: true,
                      // fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 3, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        //color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 20,
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Exp Date',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            'CVV',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              //labelText: 'XXXX XXX XXXX XXXX',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              // filled: true,
                              // fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 3, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                //color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _cvvController,
                            decoration: InputDecoration(
                              //labelText: 'XXXX XXX XXXX XXXX',
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              // filled: true,
                              // fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 3, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                                //color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 50,
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.only(left: 0),
                        title: const Text("Save my details"),
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
