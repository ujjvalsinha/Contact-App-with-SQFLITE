import 'package:contactapp/DatabaseHelper.dart';
import 'package:contactapp/Edit.dart';
import 'package:contactapp/NoteDetail.dart';
import 'package:contactapp/contact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Note.dart';

class Notelist extends StatefulWidget {
  @override
  _NotelistState createState() => _NotelistState();
}

class _NotelistState extends State<Notelist> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Contacts"),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail2(Note('', ''," "), 'Add Note');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return GestureDetector(
            onTap: (){navigateToDetail(this.noteList[position], 'Edit to do');},
                      child: Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.grey,
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person),
                ),
                title: Text(
                  this.noteList[position].name,style: TextStyle(color: Colors.white),
                ),
                
                // trailing: GestureDetector(
                //   child: Icon(Icons.open_in_new, color: Colors.white),
                //   onTap: () {
                //     navigateToDetail(this.noteList[position], 'Edit to do');
                //   },
                // ),
              ),
            ),
          );
        });
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return contact(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }
   void navigateToDetail2(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Edit(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        }
      });
    });
  }
}
