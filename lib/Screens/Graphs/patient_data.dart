import 'package:flutter/material.dart';
import 'package:psoriasis_application/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientsData {
  static final String columnDate = "";
  static final String columnP3_10years = "";
  static final String columnP3_20years = "";
  static final String columnP3_bright_red = "";
  static final String columnP3_number_of_tablets = "";
  static final String columnP3_rheumatologist = "";
  static final String columnP3_ultraviolet = "";
  static final String columnP3_which_tablets = "";
  static final String columnPart1 = "";
  static final String columnPart2 = "";
  static final String columnPart3 = "";
  static final String columnID = "";

  final DateTime date;
  final bool p3_10years;
  final bool p3_20years;
  final bool p3_bright_red;
  final int no_tablets;
  final bool p3_rheumatologist;
  final bool p3_ultraviolet;
  final List p3_which_tablets;
  final int part1;
  final int part2;
  final int part3;

  PatientsData({
    required this.date,
    required this.p3_10years, 
    required this.p3_20years,
    required this.p3_bright_red, 
    required this.no_tablets, 
    required this.p3_rheumatologist, 
    required this.p3_ultraviolet, 
    required this.p3_which_tablets, 
    required this.part1, 
    required this.part2, 
    required this.part3
  }
  );

  Map toMap(){
    Map<String, dynamic> map = {
      columnDate: date,
      columnP3_10years: p3_10years,
      columnP3_20years: p3_20years,
      columnP3_bright_red: p3_bright_red,
      columnP3_number_of_tablets: no_tablets,
      columnP3_rheumatologist: p3_rheumatologist,
      columnP3_ultraviolet: p3_ultraviolet,
      columnP3_which_tablets: p3_which_tablets,
      columnPart1: part1,
      columnPart2: part2,
      columnPart3: part3,
    };
    return map;
  }

  static PatientsData fromMap(Map map){
    return new PatientsData( ///new
      date: map[columnDate],
      p3_10years: map[columnP3_10years], 
      p3_20years: map[columnP3_20years], 
      p3_bright_red: map[columnP3_bright_red], 
      no_tablets: map[columnP3_which_tablets], 
      p3_rheumatologist: map[columnP3_rheumatologist], 
      p3_ultraviolet: map[columnP3_ultraviolet], 
      p3_which_tablets: map[columnP3_which_tablets], 
      part1: map[columnPart1], 
      part2: map[columnPart2], 
      part3: map[columnPart3]);
  }

}