import 'package:contactapp/DatabaseHelper.dart';
import 'package:contactapp/Edit.dart';
import 'package:contactapp/Note.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class contact extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  contact(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return contactState(this.note, this.appBarTitle);
  }
}

class contactState extends State<contact> {
  _launchURL() async {
    const url = "tel:8434277416";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _textMe() async {
    // Android
    const uri = 'sms:+39 348 060 888?body=hello%20there';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:0039-222-060-888';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  _mailURL() async {
    const url = "mailto:<ujjvalsinha>?subject=<subject>&body=<body>";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static var _priorities = ['High', 'Low'];
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Note note;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  contactState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    nameController.text = note.name;
    numberController.text = note.number;

    return WillPopScope(
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              title: Text("Contact"),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    moveToLastScreen();
                  }),
              actions: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Edit(note, appBarTitle)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Icon(Icons.edit),
                    ))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(2),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Container(
                          height: 200,
                          color: Color(0xFFE8E8E8),
                          child: Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.white,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Color(0xFFE8E8E8),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: Text(
                                      '📞',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Bree Serif'),
                                    )),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Text('📞',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Bree Serif')),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Text('✉',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Bree Serif')),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: Text(
                                      note.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Bree Serif'),
                                    )),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Text(note.number,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Bree Serif')),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: Text(note.email,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Bree Serif')),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.red, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.white,
                                  )),
                              onTap: () {
                                _launchURL();
                              },
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.greenAccent, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(Icons.message)),
                              onTap: () {
                                _textMe();
                              },
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.orange, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(Icons.mail)),
                              onTap: () {
                                _mailURL();
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
    }
    return priority;
  }

  void updateTitle() {
    note.name = nameController.text;
  }

  void updateDescription() {
    note.number = numberController.text;
  }

  void updateEmail() {
    note.email = emailController.text;
  }

  void _save() async {
    moveToLastScreen();

    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
      print("update $result");
    } else {
      result = await helper.insertNote(note);
      print(result);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Task Deleted');
    } else {
      _showAlertDialog('Status', 'Error');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message), //
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
