// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:psoriasis_application/constants.dart';

class MyDialog extends StatefulWidget {
  MyDialog({
    required this.tablets,
    required this.selectedTablets,
    required this.onSelectedTabletsListChanged,
    other
  });

  final List<String> tablets;
  final List<String> selectedTablets;
  final ValueChanged<List<String>> onSelectedTabletsListChanged;
  String other ='';
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<String> _tempSelectedTablets = [];
  @override
  void initState() {
    _tempSelectedTablets = widget.selectedTablets;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.3,
        height: size.height * 0.5,
        constraints: BoxConstraints(maxWidth: 350),
        child: Column(
          children: <Widget>[
                const Text(
                  'Select psoriasis tablets and/or injections',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    ),  
                ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.tablets.length,
                  itemBuilder: (BuildContext context, int index) {
                    final tabletName = widget.tablets[index];
                    return Container(
                      child: CheckboxListTile(
                          title: Text(tabletName),
                          value: _tempSelectedTablets.contains(tabletName),
                          activeColor: kPrimaryColor,
                          checkColor: Colors.white,
                          onChanged: (bool? value) {
                            if (value!) {
                              if (!_tempSelectedTablets.contains(tabletName)) {
                                setState(() {
                                  _tempSelectedTablets.add(tabletName);
                                });
                              }
                            } else {
                              if (_tempSelectedTablets.contains(tabletName)) {
                                setState(() {
                                  _tempSelectedTablets.removeWhere(
                                      (String tablet) => tablet == tabletName);
                                });
                              }
                            }
                            widget
                                .onSelectedTabletsListChanged(_tempSelectedTablets);
                          }),
                    );
                  }),
            ),
            Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.20,
                  height: size.height * 0.05,
                  constraints: BoxConstraints(maxWidth: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                        }, 
                      child: Text('Done'),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}