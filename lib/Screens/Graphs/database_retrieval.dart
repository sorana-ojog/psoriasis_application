import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:psoriasis_application/Screens/Graphs/patient_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:psoriasis_application/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRetrieval{

  // static Future<List<PatientsData>> _getPatientsFromFirestore() async {
  //   CollectionReference ref = FirebaseFirestore.instance.collection('form');
  //   Stream<QuerySnapshot<Object?>> eventsQuery = await ref
  //       .where("user_ID", isEqualTo: true)
  //       .snapshots();
  //   HashMap<String, PatientsData> patientshashMap = new HashMap<String, PatientsData>();
  //   eventsQuery.documents.forEach((document)){
      
  //   });
  // }

}