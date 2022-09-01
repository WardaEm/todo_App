
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/archive.dart';
import '../../models/done.dart';
import '../../models/new.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());

 static AppCubit get(context)=>BlocProvider.of(context);

  int currentindex=0;




List<Map>newTask=[];
  List<Map>doneTask=[];
  List<Map>archiveTask=[];

  List<String>titles=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];
  bool isBottomSheetShown=false;
  IconData fabicon=Icons.edit;



  Database? database;
  List<Widget>Screens=[
    NewScreen(),
     DoneScreen(),
     ArchiveScreen(),
  ];
void barchange(int index){
currentindex=index;
emit(AppChangeState());
}




 void creatDatabase(){
       openDatabase(
        'todo.db',
        version:1,
        onCreate:(database,version){
          print('database created');
          database.execute('CREATE TABLE  tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)').then((value){
            print('table created');
          }).catchError((error){
            print('Error When Creating Table ${error.toString()}');
          });
        },



        onOpen:(database){
    getDataFromDatabase(database);


    print('database opened');
    },).then((value) {
      database=value;
      emit(AppCreatState());
       });




  }


  insertDatabase({
 required String ?title,
    required String ?time,
    required String ?date,
})async {
    return await database?.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks (title,date,time,status) VALUES("$title","$time","$date","NEW")')
          .then((value) {
        print('$value inserted success');
        emit(AppInsertState());

        getDataFromDatabase(database);
           // emit(AppGetDatabaseState());
        });
      }).catchError((error) {
        print('Error When Inser New Record ${error.toString()}');
      });

  }
  
  
void getDataFromDatabase(database) {
  newTask=[];
  doneTask=[];
  archiveTask=[];
   emit(AppGetDatabaseLoadingState());
   database.rawQuery('SELECT * FROM tasks').then((value) {

  value.forEach((element) {
 if(element['status']=='NEW'){
   newTask.add(element);
 }

  else if(element['status']=='done')
    {doneTask.add(element);}

  else
    archiveTask.add(element);
   });

   emit(AppGetDatabaseState());
   });
 }

 void  updateData({
  required String status,
   required int id,
})async{
 database!.rawUpdate(
        'UPDATE tasks SET status = ?  WHERE id=?',
        ['$status',id, ]).then((value) {
          getDataFromDatabase(database);
          emit(AppupdateState());
 });


  }


  void  deleteData({

    required int id,
  })async{
    database!.rawDelete(
        'Delete From tasks WHERE id= ?',[id])
     .then((value) {
      getDataFromDatabase(database);
      emit(AppdeleteState());
    });
  }


  void changeBottomSheet({
  required bool isShow,
    required IconData icon,

  }){
  isBottomSheetShown=isShow;
  fabicon=icon;
  emit(AppBottomShownState());




  }
}

