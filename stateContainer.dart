import 'package:flutter/material.dart';
import 'package:test1/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test1/utlis/database_helper.dart';
import 'dart:async';
class StateContainer extends StatefulWidget
{
  final Widget child;
  final Note note;
  StateContainer(this.child,this.note);
  static StateContainerState of(BuildContext context)
  {
    return(context.inheritFromWidgetOfExactType(InheritedStateContainer)as InheritedStateContainer).data;
  }
  @override

  State<StatefulWidget> createState() => new StateContainerState();
}

class StateContainerState extends State<StateContainer>
{
  List<Note> noteList;
   int count ;
  DatabaseHelper databaseHelper = DatabaseHelper();
void updateListView() {

  final Future<Database> dbFuture = databaseHelper.initializeDatabase();
  dbFuture.then((database) {

    Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
    noteListFuture.then((noteList) {
      setState(() {
        this.noteList = noteList;
        this.count = noteList.length;
      });
    });
  });
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

}
class InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;
  InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}