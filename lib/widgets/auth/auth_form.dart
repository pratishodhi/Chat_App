import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;

  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userName = '';
  var _userPassword = '';
  var _userEmail = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Pick An Image'),
        backgroundColor: Colors.redAccent,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userName.trim(),
        _userPassword.trim(),
        _userEmail.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Username must be atleast 4 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value;
                        },
                        decoration: InputDecoration(labelText: 'Username')),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Password must be atleast 6 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      textColor: Theme.of(context).primaryColor,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
