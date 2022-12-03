import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaptry/page/widgets/appTheme.dart';
import 'package:swaptry/page/widgets/utils.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedRegister;

  const LoginPage({
    Key? key,
    required this.onClickedRegister,
    
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    child:Center(
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: textStyle(18, semiBold, white)
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: widget.onClickedRegister,
                    child: SizedBox(
                      width: 119, height: 55,
                      child: Center(
                        child: Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: textStyle(18, semiBold, black)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome\nBack!',
                textAlign: TextAlign.start,
                style: textStyle(40, bold, darkerGrey)
              ),
              Text(
                'Glad to see you again.',
                textAlign: TextAlign.start,
                style: textStyle(18, medium, darkerGrey)
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
                      cursorColor: Colors.black,
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
              const SizedBox(height: 50,),
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: signIn,
                  style: buttonStyle,
                  child: Center(
                    child: Text(
                      'Log In',
                      style: textStyle(18, semiBold, white),
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

  Future signIn() async{
    try {
      if(_key.currentState!.validate()){
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), 
          password: passwordController.text.trim(),
        );
        Navigator.pop(context);
      }
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        setState(() {shadowColorPass = Colors.red;});
      }else if(e.code != 'wrong-password'){
        setState(() {shadowColorPass = darkGrey;});
      }
      
      if (e.code == 'user-not-found') {
        setState(() {shadowColorEmail = Colors.red;});
      }else if(e.code != 'user-not-found'){
        setState(() {shadowColorEmail = darkGrey;});
      }

      Utils.showSnackBar(e.message);
    } 
  }
}