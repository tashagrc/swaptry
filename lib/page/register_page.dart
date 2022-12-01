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
    var confirmPass;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: widget.onClickedLogin,
                    child: const SizedBox(
                      width: 119, height: 55,
                      child: Center(
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight:FontWeight.w600,
                            fontSize: 18,
                          ),
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
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0,3),
                          blurRadius: 11,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Let\'s create\nyou an account!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff4A4A4A),
                ),
              ),
              const SizedBox(height: 30,),
              Stack(
                children:[
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      controller: emailController,
                      autocorrect: false,
                      validator: (value) {
                        if(value!.isEmpty || value == null){
                          return 'Please enter a valid email address.';
                        }

                        String pattern = r'\w+@\w+\.\w+';
                        RegExp regex = RegExp(pattern);
                        if(!regex.hasMatch(value)){
                          return 'Invalid E-mail Address format.';
                        } 
                        
                        
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
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
                      color: Colors.white,
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
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      controller: passwordController,
                      autocorrect: false,
                      validator: (value) {
                        confirmPass = value;
                        if(value!.isEmpty|| value.length < 7){
                          return 'Password must be at least 7 characters long.';
                        }
                        
                        return null;
                      },
                      obscureText: true,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
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
                      color: Colors.white,
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
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      autocorrect: false,
                      validator: (value) {
                        if(value != confirmPass){
                          return 'Password doesn\'t match!';
                        }
                        
                        return null;
                      },
                      obscureText: true,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
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
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, 
                    backgroundColor: purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                  ),
                  
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      ),
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

  void changeShadowColour(int idx){
    if(shadowColorEmail == Colors.red && idx == 1){
      setState(() {
        shadowColorEmail = const Color(0xff565656);
      });
    }else if(idx == 1){
      setState(() {
        shadowColorEmail = Colors.red;
      });
    }

    if(shadowColorPass == Colors.red && idx == 2){
      setState(() {
        shadowColorPass = const Color(0xff565656);
      });
    }else if(idx == 2){
      setState(() {
        shadowColorPass = Colors.red;
      });
    }
  }

  Future signUp() async{
    try {
      if(_key.currentState!.validate()){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(), 
          password: passwordController.text.trim(),
        );
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    } 
  }
}