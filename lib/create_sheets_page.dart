import 'package:flutter/material.dart';
import 'package:google_sheets/main.dart';
import 'package:google_sheets/user_form_widget.dart';
import 'package:google_sheets/user_sheet_api.dart';


class CreateSheetsPage extends StatelessWidget {

  const CreateSheetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: UserFormWidget(onSavedUser: (user) async {
            final id = await UserSheetsApi.getRowCount() + 1;
            final newUser = user.copy(id: id);
            await UserSheetsApi.insert([newUser.toJson()]);
          }),
        ),
      ),
    );

    // Future insertUser() async{
    //   final users =[
    //     User(id:1, name:'Ali', email:'mmohammadalai.com', isBeginner:true,),
    //     User(id:2, name:'mohamad', email:'mmohammadalai.com', isBeginner:false,),
    //     User(id:3, name:'omar', email:'mmohammadalai.com', isBeginner:true,),
    //     User(id:4, name:'samer', email:'mmohammadalai.com', isBeginner:false,),
    //   ];
    //   final jsonUsers = users.map((user) => user.toJson()).toList();
    //   await UserSheetsApi.insert(jsonUsers);
    //
    // }
  }
}
