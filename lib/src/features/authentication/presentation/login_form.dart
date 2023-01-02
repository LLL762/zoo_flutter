import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:zoo_flutter/src/features/authentication/model/login_request.dart';

import '../services/i_log_in_service.dart';
export 'login_form.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  LoginRequest? model;
  bool _isFormValid = false;
  String? errMsg;
  late ILogInService logInService;

  onfieldChange(value) async {
    print(await logInService.getLogInStatus());
    setState(() {
      _isFormValid = _formKey.currentState!.validate();
    });
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    logInService = ILogInService("");
  }

  reset() {
    for (var field in _formKey.currentState!.fields.values) {
      field.reset();
    }
    setState(() {
      _isFormValid = false;
    });
  }

  onSubmit() async {
    final formData = _formKey.currentState!.fields
        .map((key, textField) => MapEntry(key, textField.value));

    try {
      final resp = await logInService.logIn(formData);

      if (resp.statusCode == 401) {
        setState(() {
          errMsg = "Credentials not valid";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: FormBuilder(
          key: _formKey,
          child: Column(children: [
            FormBuilderTextField(
                name: "username",
                onChanged: onfieldChange,
                maxLength: 25,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                    const InputDecoration(hintText: "enter your username"),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(5),
                ])),
            FormBuilderTextField(
                maxLength: 255,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: onfieldChange,
                name: "password",
                decoration:
                    const InputDecoration(hintText: "enter your password"),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(12),
                ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isFormValid ? onSubmit : null,
                  child: const Text('Submit'),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: reset,
                  child: const Text('reset'),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(style: const TextStyle(color: Colors.red), errMsg ?? ""),
          ])),
    );
  }
}
