import 'package:flutter/material.dart';
import 'package:onlinestorecapp/src/blocs/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
          children: <Widget>[
            _createBackground(context, size),
            _loginForm(context, size)
          ],
        )
    );
  }

  Widget _createBackground(BuildContext context, size) {
    final oBackground =  Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(90, 1, 158, 1.0),
            Color.fromRGBO(33, 2, 56, 1.0)
          ]
        )
      )
    );

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    return Stack(
      children: <Widget>[
        oBackground,
        Positioned(top: 10.0, left: 30.0, child: circle),
        Positioned(top: -30.0, right: -30.0, child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle),
        Positioned(bottom: 110.0, right: 80.0, child: circle),
        Positioned(bottom: -50.0, left: -20.0, child: circle),

        Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.supervised_user_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Mobillesfern', style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ]
    );
  }

  Widget _loginForm(BuildContext context, size) {
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 170.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 9.0),
                  spreadRadius: 4.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Inicio', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 30.0),
                _createEmail(bloc),
                SizedBox(height: 20.0),
                _createPassword(bloc),
                SizedBox(height: 30.0),
                _createButton(bloc)
              ],
            ),
          ),

          Text('Recuperar Contraseña'),
          SizedBox(height: 100.0)

        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot ) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon( Icons.alternate_email, color: Colors.deepPurple ),
                  hintText: 'ejemplo@correo.com',
                  labelText: 'Email',
                  counterText: snapshot.data,
                  errorText: snapshot.error
                ),
                onChanged: bloc.changeEmail,
            )
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon( Icons.lock_outline, color: Colors.deepPurple ),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error
              ),
              onChanged: bloc.changePassword,
            )
        );
      }
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return RaisedButton(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
              child: Text('Iniciar sesión')
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(context, bloc) : null
        );
      }
    );
  }

  _login(BuildContext context, LoginBloc bloc) {
    print('==========================');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('==========================');
    Navigator.pushNamed(context, 'home');
  }

}
