import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaptry/page/widgets/appTheme.dart';
import 'package:swaptry/page/widgets/utils.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const RegisterPage({
    Key? key,
    required this.onClickedLogin,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Color shadowColorPass  = const Color(0xff565656);
  Color shadowColorEmail  = const Color(0xff565656);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? confirmPass;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: widget.onClickedLogin,
                    child: SizedBox(
                      width: 119, height: 55,
                      child: Center(
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: textStyle(18, semiBold, black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 119, height: 55,
                    decoration: BoxDecoration(
                      color: purple,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.2),
                          offset: const Offset(0,3),
                          blurRadius: 11,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: textStyle(18, semiBold, white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Let\'s create\nyou an account!',
                textAlign: TextAlign.start,
                style: textStyle(35, bold, darkerGrey)
              ),
              const SizedBox(height: 30,),
              Stack(
                children:[
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColorEmail.withOpacity(0.2),
                          offset: const Offset(0,5),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      controller: emailController,
                      autocorrect: false,
                      validator: (value) {
                        if(value!.isEmpty){
                          setState(() {shadowColorEmail = Colors.red;});
                          return 'Please enter a valid email address.';
                        }

                        String pattern = r'\w+@\w+\.\w+';
                        RegExp regex = RegExp(pattern);
                        if(!regex.hasMatch(value)){
                          setState(() {shadowColorEmail = Colors.red;});
                          return 'Invalid E-mail Address format.';
                        } 
                        setState(() {shadowColorEmail = darkGrey;});
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: black,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email_rounded),
                      ),
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 30,),
              Stack(
                children:[
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColorPass.withOpacity(0.2),
                          offset: const Offset(0,5),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      controller: passwordController,
                      autocorrect: false,
                      validator: (value) {
                        confirmPass = value;
                        if(value!.isEmpty|| value.length < 7){
                          setState(() {shadowColorPass = Colors.red;});
                          return 'Password must be at least 7 characters long.';
                        }
                        setState(() {shadowColorPass = darkGrey;});
                        return null;
                      },
                      obscureText: true,
                      cursorColor: black,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Stack(
                children:[
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColorPass.withOpacity(0.2),
                          offset: const Offset(0,5),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                      autocorrect: false,
                      validator: (value) {
                        if(value!.isEmpty){
                          setState(() {shadowColorPass = Colors.red;});
                          return 'Please input this field!';
                        }
                        if(value != confirmPass){
                          setState(() {shadowColorPass = Colors.red;});
                          return 'Password doesn\'t match!';
                        }
                        setState(() {shadowColorPass = darkGrey;});
                        return null;
                      },
                      obscureText: true,
                      cursorColor: black,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: signUp,
                  style: buttonStyle,
                  
                  child: Center(
                    child: Text(
                      'Register',
                      style: textStyle(18, semiBold, white)
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }

  Future signUp() async{
    try {
      if(_key.currentState!.validate()){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(), 
          password: passwordController.text.trim(),
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    } 
  }
}