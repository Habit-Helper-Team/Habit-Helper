import 'dart:convert';

import 'package:habit_helper/screens/habits_screen.dart';
import 'package:flutter/material.dart';
import 'package:habit_helper/screens/habits_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class HabitSettingsPage extends StatefulWidget {
  const HabitSettingsPage({super.key});

  @override
  State<HabitSettingsPage> createState() => _HabitSettingsPageState();
}

class _HabitSettingsPageState extends State<HabitSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: HabitWidget(),
      ),
    );
  }
}



class HabitWidget extends StatefulWidget {
  const HabitWidget({super.key});

  @override
  State<HabitWidget> createState() => _HabitWidgetState();
}
class HabitModel {
  late TextEditingController textController1;
  late FocusNode textFieldFocusNode1;

  bool switchValue = true;

  late TextEditingController textController2;
  late FocusNode textFieldFocusNode2;

  late TextEditingController textController3;
  late FocusNode textFieldFocusNode3;

  late FocusNode unfocusNode;

  HabitModel() {
    textController1 = TextEditingController();
    textFieldFocusNode1 = FocusNode();

    textController2 = TextEditingController();
    textFieldFocusNode2 = FocusNode();

    textController3 = TextEditingController();
    textFieldFocusNode3 = FocusNode();

    unfocusNode = FocusNode();
  }

  void dispose() {
    textController1.dispose();
    textFieldFocusNode1.dispose();

    textController2.dispose();
    textFieldFocusNode2.dispose();

    textController3.dispose();
    textFieldFocusNode3.dispose();
  }
}


class _HabitWidgetState extends State<HabitWidget> {
  late HabitModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HabitModel();

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.switchValue = true;
    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
  Future addHabit(Habit t) async {
    String stringHabit = await fetchData();
    final habitList = jsonDecode(stringHabit);
    List habits = [];
    for (var todo in habitList) {
      setState(() {
        habits.add(Habit().fromJson(todo));
      });
    }
    setState(() {
      habits.add(t);
    });
    saveHabit(habits);
  }
  void saveHabit(List habits) async {
    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    List items = habits.map((e) => e.toJson()).toList();
    await prefs1.setString('habits', jsonEncode(items));
  }
  Future fetchData() async {
    final prefs1 = await SharedPreferences.getInstance();
    return prefs1.getString('habits') ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: '#1A1F24'.toColor(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: '#1A1F24'.toColor(),
          automaticallyImplyLeading: false,
          leading: IconButton(
            // buttonSize: 60,
            icon: Icon(
              Icons.close_rounded,
              color: '#FFFFFF'.toColor(),
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Habits()),
              );
            },
          ),
          title: Text(
            'Habit Settings',
            style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
          //     child: SizedBox(
          //       width: 70,
          //       height: 32,
          //       child: ElevatedButton(
          //         onPressed: () {
          //           print('Text Controller 1 Value: ${_model.textController1.text}');
          //           print('Text Controller 2 Value: ${_model.textController2.text}');
          //           print('Text Controller 2 Value: ${_model.switchValue}');
          //           print('Text Controller 2 Value: ${_model.textController3.text}');
  
          //           print('Button pressed ...');
          //         },
          //         style: ElevatedButton.styleFrom(
          //           padding: EdgeInsets.zero,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(4),
          //           ),
          //           elevation: 0,
          //           backgroundColor: const Color(0xFF02B732),
          //         ),
          //         child: const Text(
          //           'Save',
          //           style: TextStyle(
          //             letterSpacing: 0,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     )
          //   ),
          // ],
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: TextFormField(
                    controller: _model.textController1,
                    focusNode: _model.textFieldFocusNode1,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Habit Name',
                      hintText: 'Enter habit name...',
                      hintStyle: TextStyle(
                        letterSpacing: 0,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: '#B2FF5B'.toColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(165, 255, 22, 22),
                          width: 2,
                        ),
                        borderRadius:  BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(
                      letterSpacing: 0,
                      color: Colors.white,
                    ),
                    // validator:
                    //     _model.textController1Validator.asValidator(context),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                              letterSpacing: 0,
                              color: Colors.white,
                        ),
                      ),
                      Switch(
                        value: _model.switchValue!,
                        onChanged: (newValue) async {
                          setState(() => _model.switchValue = newValue!);
                        },
                        activeColor: '#FFFFFF'.toColor(),
                        activeTrackColor:
                            '#8B97A2'.toColor(),
                        inactiveTrackColor:
                            '#1A1F24'.toColor(),
                        inactiveThumbColor:
                            '#8B97A2'.toColor(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: TextFormField(
                    controller: _model.textController2,
                    focusNode: _model.textFieldFocusNode2,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Time',
                      hintText: 'Choose time...',
                      hintStyle: TextStyle(letterSpacing: 0),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: '#B2FF5B'.toColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      letterSpacing: 0,
                      color: Colors.white,
                      ),
                    // validator:
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                  child: TextFormField(
                    controller: _model.textController3,
                    focusNode: _model.textFieldFocusNode3,
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Duration',
                      hintText: 'Choose duration...',
                      hintStyle: TextStyle(letterSpacing: 0),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: '#B2FF5B'.toColor(),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      letterSpacing: 0,
                      color: Colors.white,
                    ),
                    // validator:
                    //     _model.textController3Validator.asValidator(context),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         'Days',
                //         style: TextStyle(letterSpacing: 0,
                //             color: Colors.white),
                //       ),
                //       Row(
                //         mainAxisSize: MainAxisSize.max,
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               color: '#B2FF5B'.toColor(),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             alignment: AlignmentDirectional(0, 0),
                //             child: Text(
                //               'Mon',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: '#262D34'.toColor(),
                //                 letterSpacing: 0,
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 4),
                //           Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               color: '#B2FF5B'.toColor(),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             alignment: AlignmentDirectional(0, 0),
                //             child: Text(
                //               'Tue',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: '#262D34'.toColor(),
                //                 letterSpacing: 0,
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 4),
                //           Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               color: '#B2FF5B'.toColor(),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             alignment: AlignmentDirectional(0, 0),
                //             child: Text(
                //               'Wed',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: '#262D34'.toColor(),
                //                 letterSpacing: 0,
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 4),
                //           Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               color: '#B2FF5B'.toColor(),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             alignment: AlignmentDirectional(0, 0),
                //             child: Text(
                //               'Thu',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: '#262D34'.toColor(),
                //                 letterSpacing: 0,
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 4),
                //           Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               color: '#B2FF5B'.toColor(),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             alignment: AlignmentDirectional(0, 0),
                //             child: Text(
                //               'Fri',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: '#262D34'.toColor(),
                //                 letterSpacing: 0,
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 4),
                //           Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               color: '#B2FF5B'.toColor(),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             alignment: AlignmentDirectional(0, 0),
                //             child: Text(
                //               'Sat',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 letterSpacing: 0,
                //                 color: '#262D34'.toColor(),
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 4),
                //           Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               color: '#B2FF5B'.toColor(),
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             alignment: AlignmentDirectional(0, 0),
                //             child: Text(
                //               'Sun',
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                 color: '#262D34'.toColor(),
                //                 letterSpacing: 0,
                //               )
                //             ),
                //           ),
                //         ]
                //       ),
                    
                    
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: Align(
                //     alignment: AlignmentDirectional(0, 1),
                //     child: Padding(
                //       padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                //       child: ElevatedButton(
                //         onPressed: () {
                //           print('Button pressed ...');
                //         },
                //         style: ElevatedButton.styleFrom(
                //           minimumSize: const Size(double.infinity, 50),
                //           padding: EdgeInsets.zero,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           elevation: 2,
                //           backgroundColor: Color(0xFFFF0000),
                //           foregroundColor: Colors.white,
                //           textStyle: const TextStyle(
                //             letterSpacing: 0,
                //           ),
                //         ),
                //         child: const Text(
                //           'Delete',
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_model.textController1.text.isEmpty ||
                              _model.textController2.text.isEmpty ||
                              !RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$')
                                  .hasMatch(_model.textController2.text) ||
                              int.tryParse(_model.textController3.text) == null) {
                            return;
                          }
                          String name = _model.textController1.text;
                          String time = _model.textController2.text;
                          int days = int.tryParse(_model.textController3.text) ?? 0;
                          Habit new_habit = Habit(title: name, target: days);
                          addHabit(new_habit);
                          Future.delayed(Duration(milliseconds: 200), () {
                            Navigator.pushReplacementNamed(context, '/');
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          backgroundColor: const Color(0xFF02B732),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            letterSpacing: 0,
                            fontSize: 24,
                          ),
                        ),
                        child: const Text(
                          'Save',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
