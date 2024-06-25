import 'package:consulta_produto/routes.dart';
import 'package:consulta_produto/services/auth/auth_service.dart';
import 'package:consulta_produto/utils/consts.dart';
import 'package:consulta_produto/utils/responsive.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordIsVisible = false;
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<void> _onSubmit() async {
    if (_usuarioController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty) {
      await AuthService().login(_usuarioController.text, _senhaController.text);
      Navigator.popAndPushNamed(context, AppRoutes.consulta);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: selectionColor,
          ),
          height: 400,
          margin: EdgeInsets.only(
            top: size.height * 0.1,
            left: Responsive.isDesktop(context) ? size.width * 0.35 : 20,
            right: Responsive.isDesktop(context) ? size.width * 0.35 : 20,
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/vetores-gratis/ilustracao-do-conceito-de-login_114360-739.jpg'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usuarioController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.black26,
                    prefixIcon: Icon(Icons.people),
                    hintText: 'Usuário'),
              ),
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: TextField(
                        obscureText: !_passwordIsVisible,
                        controller: _senhaController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.black26,
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Senha',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        icon: Icon(
                          Icons.visibility,
                          color: _passwordIsVisible
                              ? Colors.white
                              : Colors.black26,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordIsVisible = !_passwordIsVisible;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FilledButton(onPressed: _onSubmit, child: Text('Entrar'))
            ],
          ),
        ),
      ),
    );
  }
}
