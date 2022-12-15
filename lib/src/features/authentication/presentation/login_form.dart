import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  bool _isFormValid = false;

  onSubmit() {
    print(_formKey.currentState!.isValid);
  }

  onfieldChange(value) {
    setState(() {
      _isFormValid = _formKey.currentState!.validate();
    });
  }

  reset() {
    for (var field in _formKey.currentState!.fields.values) {
      field.reset();
    }
    setState(() {
      _isFormValid = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
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
          )
        ]));
  }
}
