import 'package:flutter/material.dart';
import 'package:google_sheets/button_widget_page.dart';
import 'package:google_sheets/user.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({Key? key, required this.onSavedUser}) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late bool isBeginner;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() {
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    isBeginner = true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildName(),
          const SizedBox(
            height: 16,
          ),
          buildEmail(),
          const SizedBox(
            height: 16,
          ),
          buildFlutterBeginner(),
          const SizedBox(
            height: 16,
          ),
          buildSubmit(),
        ],
      ),
    );
  }

  Widget buildSubmit() => ButtonWidget(
        text: 'SAVE',
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();

          if (isValid) {
            final user = User(
              name: controllerName.text,
              email: controllerEmail.text,
              isBeginner: isBeginner,
            );
            widget.onSavedUser(user);
          }
        },
      );

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Name' : null,
      );

  Widget buildEmail() => TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: controllerEmail,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && !value.contains('@') ? 'Enter Email' : null,
      );

  Widget buildFlutterBeginner() => SwitchListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: isBeginner,
        title: const Text('Is Flutter Beginner?'),
        onChanged: (bool value) {
          setState(() {
            isBeginner = value;
          });
        },
      );
}
