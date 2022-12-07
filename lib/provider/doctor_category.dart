import 'package:flutter/material.dart';

class DoctorCategory {
  String type;
  String description;

  DoctorCategory({
    required this.type,
    required this.description,
  });
}

class DoctorsCategories with ChangeNotifier {
  List<DoctorCategory> _category = [
    DoctorCategory(
      type: 'Cardiology',
      description: 'Cardiology is A branch of medicine that specializes in diagnosing and treating diseases of the heart, blood vessels, and circulatory system.',
    ),
    DoctorCategory(
      type: 'Neurology',
      description: 'Neurology is a branch of medicine or biology that deals with the anatomy, functions, and organic disorders of nerves and the nervous system.',
    ),
    DoctorCategory(
      type: 'Urology',
      description: 'Urology is a branch of medicine and physiology concerned with the function and disorders of the urinary system.',
    ),
    DoctorCategory(
      type: 'Dentist',
      description: 'A Denstist is a person who is qualified to treat diseases and other conditions that affect the teeth and gums, especially the repair and extraction of teeth and the insertion of artificial ones.',
    ),
    DoctorCategory(
      type: 'Surgery',
      description: 'Surgery the branch of medical practice that treats injuries, diseases, and deformities by the physical removal, repair, or readjustment of organs and tissues, often involving cutting into the body.',
    ),
  ];

  List<DoctorCategory> get category {
    return [
      ..._category
    ];
  }
}
