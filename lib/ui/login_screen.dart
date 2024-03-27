import 'package:flutter/material.dart';
import 'package:login_repository/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  void resetFields() {
    emailController.text = '';
    passwordController.text = '';
    _formkey = GlobalKey<FormState>();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.asset(
                    'assets/images/login.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Welcome to Login Screen',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueGrey,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Email',
                    hintText: 'Enter your email address...',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !(value.contains('@'))) {
                      return 'Please enter the valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: passwordVisible,
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blueGrey,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter your password...',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty || (value.length < 6)) {
                      return 'Please enter the valid or atleast 6 digit long password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      ApiCall.login(emailController.text.toString(),
                          passwordController.text.toString(), context);
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
