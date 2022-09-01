

import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:plus/shared/components/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus/shared/cubit/cubit.dart';
import 'package:plus/shared/cubit/states.dart';

import '../models/archive.dart';
import '../models/done.dart';
import '../models/new.dart';
class Bottom extends StatelessWidget
{
var timeController = TextEditingController();
var dateController = TextEditingController();
var titleController = TextEditingController();

var scaffoldkey=GlobalKey<ScaffoldState>();
var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..creatDatabase(),
      child: BlocConsumer<AppCubit, AppStates>
        (
        listener: (BuildContext context, Object? state) {
          if(state is AppInsertState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);

          // state is! AppGetDatabaseLoadingState
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentindex],
              ),
            ),

            body: cubit.newTask ==0 ?Center(child: CircularProgressIndicator()):cubit.Screens[cubit.currentindex],

            floatingActionButton: FloatingActionButton(onPressed: () {
              if(cubit.isBottomSheetShown){
                if(formkey.currentState!.validate()){
                  cubit.insertDatabase(title: titleController.text,time: timeController.text,date: dateController.text).then((value){
                    //
                    // cubit.isBottomSheetShown =false;
                    // cubit.fabicon=Icons.edit;
                  });

                }

              }else {
                // cubit.isBottomSheetShown =false;
                // cubit.fabicon=Icons.add;
                // TextFormField(controller:titlecontroller ,validator:(value){
                //
                // },decoration:InputDecoration(label:Text('Title is :') ,hintText:'Enter task:' ,prefixIcon:Icon(Icons.title) ) ,);

                scaffoldkey.currentState?.showBottomSheet((context) =>
                    Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: formkey,
                        child: Column(mainAxisSize: MainAxisSize.min,
                          children: [


                            defaultText(

                                controller: titleController,
                                type: TextInputType.text,
                                onTap: () {
                                  print(titleController.text);
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'title must not be empty';
                                  }
                                  return null;
                                },
                                label: 'title is',
                                hint: 'Task title:',
                                prefix: Icons.title),
                            SizedBox(height: 15,),

                            defaultText(controller: timeController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showTimePicker(context: context,
                                      initialTime: TimeOfDay.now()).then((
                                      value) {
                                    timeController.text =
                                        value!.format(context);
                                    print(value.format(context));
                                  });
                                },
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'time must not be empty';
                                  }
                                },
                                label: 'time is',
                                hint: 'Task time:',
                                prefix: Icons.timer),

                            SizedBox(height: 15,),
                            defaultText(controller: dateController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showDatePicker(context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2025)).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                    print(dateController.text);
                                  });
                                },

                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return ' Date must not be empty';
                                  }
                                },
                                label: 'Date is',
                                hint: 'Task date:',
                                prefix: Icons.date_range),


                          ],
                        ),
                      ),
                    ),
                  elevation: 20.0,

                ).closed.then((value) {
                  cubit.changeBottomSheet(isShow: false, icon: Icons.edit);

                });


                cubit.changeBottomSheet(isShow: true, icon: Icons.add);

              }
            }, child: Icon(cubit.fabicon)),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentindex,
              onTap: (index) {
                cubit.barchange(index);
                //   setState((){});
                //
                //   currentindex=index;
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.access_time), label: 'clock'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_alert), label: 'alarm'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_call), label: 'call'),
              ],),


          );
        },

      ),
    );
  }


    }







