import "dart:convert";

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String id;
  String firstName;
  String lastName;
  String abb;
  String type;
  String imageUrl;
  double rating;
  double reviews;
  double patients;
  double fee;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.abb,
    required this.type,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.patients,
    required this.fee,
  });
}

class Doctors with ChangeNotifier {
  List<Doctor> _doctors = [
    Doctor(
      id: 'd1',
      firstName: "Dr. Victor",
      lastName: "Kudos",
      abb: "K.",
      type: "Urologist",
      imageUrl: "https://i.ibb.co/C9d3C8K/all.jpg",
      rating: 4.5,
      reviews: 135,
      patients: 200,
      fee: 140,
    ),
    Doctor(
      id: 'd2',
      firstName: "Dr. Kate",
      lastName: "Mary",
      abb: "M.",
      type: "Dentist",
      imageUrl: "https://i.ibb.co/JrWZwBT/pixdoc.jpg",
      rating: 2.5,
      reviews: 135,
      patients: 300,
      fee: 100,
    ),
    Doctor(
      id: 'd3',
      firstName: "Dr. Lucky",
      lastName: "Johnson",
      abb: "J.",
      type: "Neurogist",
      imageUrl: "https://i.ibb.co/9v5VpVh/5253031822098432.jpg",
      rating: 5.5,
      reviews: 165,
      patients: 600,
      fee: 180,
    ),
    Doctor(
      id: 'd4',
      firstName: "Dr. Favour",
      lastName: "Chris",
      abb: "C.",
      type: "Surgeon",
      imageUrl: "https://i.ibb.co/2S2jBPp/gettyimages-175387037-2048x2048.jpg",
      rating: 4.5,
      reviews: 125,
      patients: 1000,
      fee: 260,
    ),
    Doctor(
      id: 'd5',
      firstName: "Dr. Victor",
      lastName: "Opulence",
      abb: "O.",
      type: "Dentist",
      imageUrl: "https://i.ibb.co/9rjdRyf/da.jpg",
      rating: 5.0,
      reviews: 125,
      patients: 3000,
      fee: 380,
    ),
    Doctor(
      id: 'd6',
      firstName: "Dr. Albert",
      lastName: "Christian",
      abb: "C.",
      type: "Cardiologist",
      imageUrl: "https://i.ibb.co/841vgTm/img-new-01-770x635.jpg",
      rating: 4.0,
      reviews: 135,
      patients: 90,
      fee: 80,
    ),
  ];

  // final String? authToken;

  // Doctors(this.authToken, this._doctors);

  List<Doctor> get doctors {
    return [
      ..._doctors
    ];
  }

  // Future<void> fetchAndSetMyDoc() async {
  //   final filterString = {
  //     "auth": authToken
  //   };

  //   var url = Uri.https("my-doc-app-b9d24-default-rtdb.firebaseio.com", "/products.json", filterString);

  //   try {
  //     final response = await http.get(url);

  //     //print(json.decode(response.body));

  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;

  //     if (extractedData == null || extractedData.isEmpty) {
  //       print("fetch and set  foods is null");

  //       return;
  //     }

  //     final List<Doctor> loadedProducts = [

  //     ];

  //     extractedData.forEach((prodId, prodData) {
  //       loadedProducts.add(Doctor(
  //         id: prodId,
  //         firstName: prodData['firstName'],
  //         lastName: prodData['lastName'],
  //         abb: prodData['abb'],
  //         type: prodData['type'],
  //         imageUrl: prodData['imageUrl'],
  //         rating: prodData['rating'],
  //         reviews: prodData['reviews'],
  //         patients: prodData['patients'],
  //         fee: prodData['fee'],
  //       ));
  //     });

  //     _doctors = loadedProducts;

  //     notifyListeners();
  //   } catch (error) {
  //     print(authToken);
  //     throw (error);
  //   }
  // }

  Doctor findById(String id) {
    return _doctors.firstWhere((doctor) => doctor.id == id);
  }

  List<Doctor> findDocType(String id) {
    return _doctors.where((p) => p.type == id).toList();
  }

  void getting() async {
    //await Firebase.initializeApp(
    //  options: FirebaseOptions(
    //  apiKey: "AIzaSyDv4GRSJXS6vQm_nEZfDCUpP4_eHMi0Cro", // Your apiKey
    // appId: "1:851018653583:web:cd7965b42db35d6e0ef5fa", // Your appId
    //  messagingSenderId: "851018653583", // Your messagingSenderId
    //  projectId: "doctor-app-b6e60", // Your projectId
    // ),
    // );
  }
}
