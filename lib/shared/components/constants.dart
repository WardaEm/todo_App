import 'package:flutter/material.dart';



import '../cubit/cubit.dart';

Widget defaultButton({
  double ? width=double.infinity,
  Color ? background=Colors.blue,
  required Function ? Function() function,
  @ required String ?text,
})
=> Container(
    width:width,
    color: background,
    child: MaterialButton(
      onPressed:  function,
      child: Text(text!.toUpperCase(),style: const TextStyle(color: Colors.white),),));

Widget defaultText({
  required TextEditingController controller,
  required TextInputType type,
  required Function  validate,
  required Function  onTap,
  required  String label,
  required  String hint,
  bool ispassword=false,
  required  IconData prefix,
  IconData? suffix,
  Function ? Function()? suffixpressed,
  bool isClickable=true,

})
=>
    TextFormField(
      controller: controller,
      enabled: isClickable,
      obscureText: ispassword,
      onTap: (){
        onTap();
      },
      validator: (value){
        return validate(value);
      },

      keyboardType:type,decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        suffixIcon:suffix !=null? IconButton(onPressed:
        suffixpressed
            ,    icon: Icon(suffix)):null,

        hintText: hint,labelText:label ,border: const OutlineInputBorder()
    ),

    );
Widget buildItem(Map map,context)=>Dismissible(
  key: Key(map['id'].toString()),
  child:   Padding(

      padding: const EdgeInsets.all(20.0),

      child: Row(

        children: [

          CircleAvatar(radius: 35,child: Text('${map['date']}'),),

          SizedBox(width: 20,),

          Expanded(

            child: Column(

              mainAxisSize: MainAxisSize.min,

              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Text('${map['title']}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

                Text('${map['time']}',style: TextStyle(color: Colors.grey)),



              ],

            ),

          ),

          SizedBox(width: 20,),

          IconButton(onPressed: (){

            AppCubit.get(context).updateData(status: 'done', id: map['id']);

          }, icon: Icon(Icons.check_box)),

          IconButton(onPressed: (){

            AppCubit.get(context).updateData(status: 'archived', id: map['id']);

          }, icon: Icon(Icons.archive)),



        ],

      )





  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: map['id']);
  },
);











