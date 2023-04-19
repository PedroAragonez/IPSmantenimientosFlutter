import 'dart:convert';

import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/home_page/home_page_widget.dart';
import 'package:i_p_s_mant/models/colaborador.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  TextEditingController emailAddressLoginController;
  TextEditingController passwordLoginController;
  bool passwordLoginVisibility;
  SharedPreferences  preffs;


  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailAddressLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
    passwordLoginVisibility = false;
    _currentSession();
  }
  _currentSession() async {
    preffs = await SharedPreferences.getInstance();
    String usuario = preffs.getString("user");
    String password = preffs.getString("password");
    DatabaseProvider.getUserByEmailPassword(usuario, password).then((value) {

      if(value!=null){
        // print(json.encode(value));
        preffs.setString("user", emailAddressLoginController.text);
        preffs.setString("password", passwordLoginController.text);

        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration:
            Duration(milliseconds: 300),
            child: HomePageWidget(idUser: value,),
          ),
        );
      }else{
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('ERROR'),
            content: const Text('No se encontro el usuario'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }
  _initSession() async {
    preffs = await SharedPreferences.getInstance();
    DatabaseProvider.getUserByEmailPassword(emailAddressLoginController.text, passwordLoginController.text).then((value) {

      if(value!=null){
        // print(json.encode(value));
        preffs.setString("user", emailAddressLoginController.text);
        preffs.setString("password", passwordLoginController.text);

        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration:
            Duration(milliseconds: 300),
            child: HomePageWidget(idUser: value,),
          ),
        );
      }else{
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('ERROR'),
            content: const Text('No se encontro el usuario'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }).onError((error, stackTrace) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ERROR'),
          content: const Text('Error de conexion'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).background,
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                        'assets/images/img.png',
                      ).image,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 200,
                                height: 130,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: DefaultTabController(
                              length: 1,
                              initialIndex: 0,
                              child: Column(
                                children: [
                                  TabBar(
                                    labelColor: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    unselectedLabelColor:
                                    FlutterFlowTheme.of(context).grayLight,
                                    labelStyle: GoogleFonts.getFont(
                                      'Roboto',
                                    ),
                                    indicatorColor: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    indicatorWeight: 3,
                                    tabs: [
                                      Tab(
                                        text: 'Login',
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 10, 0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 0),
                                                  child: TextFormField(
                                                    controller:
                                                    emailAddressLoginController,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Email Address',
                                                      labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color:
                                                        Color(0x98FFFFFF),
                                                      ),
                                                      hintText:
                                                      'Enter your email...',
                                                      hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color:
                                                        Color(0x98FFFFFF),
                                                      ),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Color(0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                      ),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Color(0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .darkBackground,
                                                      contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          20, 24, 20, 24),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .tertiaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 12, 0, 0),
                                                  child: TextFormField(
                                                    controller:
                                                    passwordLoginController,
                                                    obscureText:
                                                    !passwordLoginVisibility,
                                                    decoration: InputDecoration(
                                                      labelText: 'Password',
                                                      labelStyle: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color:
                                                        Color(0x98FFFFFF),
                                                      ),
                                                      hintText:
                                                      'Enter your password...',
                                                      hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyText1
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color:
                                                        Color(0x98FFFFFF),
                                                      ),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Color(0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                      ),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                          Color(0x00000000),
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .darkBackground,
                                                      contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          20, 24, 20, 24),
                                                      suffixIcon: InkWell(
                                                        onTap: () => setState(
                                                              () => passwordLoginVisibility =
                                                          !passwordLoginVisibility,
                                                        ),
                                                        child: Icon(
                                                          passwordLoginVisibility
                                                              ? Icons
                                                              .visibility_outlined
                                                              : Icons
                                                              .visibility_off_outlined,
                                                          color:
                                                          Color(0x98FFFFFF),
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .tertiaryColor,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 24, 0, 0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      _initSession();
                                                    },
                                                    text: 'Login',
                                                    options: FFButtonOptions(
                                                      width: 230,
                                                      height: 60,
                                                      color: FlutterFlowTheme.of(
                                                          context)
                                                          .primaryColor,
                                                      textStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .subtitle2
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .textColor,
                                                      ),
                                                      elevation: 3,
                                                      borderSide: BorderSide(
                                                        color: Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius: 8,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}