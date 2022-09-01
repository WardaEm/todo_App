import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus/shared/components/constants.dart';
import 'package:plus/shared/cubit/cubit.dart';
import 'package:plus/shared/cubit/states.dart';
class NewScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


      return  BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {

          var tasks=AppCubit.get(context).newTask;

          return tasks.length>0? ListView.separated(itemBuilder:(context,index){

            return buildItem(tasks[index], context);
          },
            separatorBuilder:(context,index)=>Container(width: double.infinity,height: 1 ,color: Colors.grey[300],), itemCount:tasks.length)
          :Center(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Icon(Icons.menu),
            Text('No Tasks yet',style: TextStyle(fontSize: 30),),
            ],),
          );


          },

      );
     }

}
// Padding(
// padding: const EdgeInsets.all(20.0),
// child: Row(
// children: [
// CircleAvatar(radius: 35,child: Text('02:00 pm'),),
// SizedBox(width: 20,),
// Column(
// mainAxisSize: MainAxisSize.min,
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text('Task title',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
// Text('2 april, 2021',style: TextStyle(color: Colors.grey)),
//
// ],
// ),
// ],
// )
//
//
// );