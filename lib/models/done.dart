import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/constants.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var tasks = AppCubit
            .get(context)
            .doneTask;

        return tasks.length > 0 ? ListView.separated(
            itemBuilder: (context, index) {
              return buildItem(tasks[index], context);
            },
            separatorBuilder: (context, index) =>
                Container(
                  width: double.infinity, height: 1, color: Colors.grey[300],),
            itemCount: tasks.length)
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.menu),
              Text('No Tasks yet', style: TextStyle(fontSize: 30),),
            ],),

        );
      }   );

    }
}