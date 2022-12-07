import 'package:flutter/material.dart';

class ProfileListItems {
  Widget first;
  String second;

  ProfileListItems({
    required this.first,
    required this.second,
  });
}

class ProfileList with ChangeNotifier {
  final List<ProfileListItems> _items = [
    ProfileListItems(
      first: const Icon(Icons.person),
      second: 'Personal details',
    ),
    ProfileListItems(
      first: const Icon(Icons.settings),
      second: 'Settings',
    ),
    ProfileListItems(
      first: const Icon(Icons.credit_card),
      second: 'Payment details',
    ),
    ProfileListItems(
      first: const Icon(Icons.chat),
      second: 'FAQ',
    ),
    ProfileListItems(
      first: const Icon(Icons.toggle_on_rounded),
      second: 'Language',
    ),
  ];
  List<ProfileListItems> get items {
    return [
      ..._items
    ];
  }
}
