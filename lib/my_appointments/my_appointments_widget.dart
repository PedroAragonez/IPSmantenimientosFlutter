import 'dart:convert';

import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/models/book.dart';
import 'package:i_p_s_mant/models/colaborador.dart';
import 'package:i_p_s_mant/models/requisitorEvento.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appointment_details/appointment_details_widget.dart';
import '../components/book_appointment_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppointmentsWidget extends StatefulWidget {
  final colaborador usuario;
  const MyAppointmentsWidget({Key key, this.usuario}) : super(key: key);

  @override
  _MyAppointmentsWidgetState createState() => _MyAppointmentsWidgetState();
}

class _MyAppointmentsWidgetState extends State<MyAppointmentsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<requisitorEvento> listaEventos = [];
  SharedPreferences preffs;
  List<book> listBook;
  @override
  void initState() {
    super.initState();
    _getRequisitorEventos();
  }
  static List<book> parseBook(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<book>((json) => book.fromJson(json)).toList();
  }
  _getRequisitorEventos() async {
    preffs = await SharedPreferences.getInstance();
    String temp = preffs.getString("listaBook");


    setState(() {
      print(temp);
      listBook = parseBook(temp);
    });


    // DatabaseProvider.getEstatusDetalleEventoByAsesor(widget.usuario.usuario).then((value) {
    //   int count = 0;
    //   value.forEach((element) {
    //     DatabaseProvider.getDetalleEventoById(element.id.toString()).then((detalle){
    //       DatabaseProvider.getRequisitorEventoById(detalle.idEvento.toString()).then((requisitor) {
    //         setState(() {
    //           listaEventos.add(requisitor);
    //         });
    //       });
    //
    //     });
    //     count++;
    //   });
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).background,
        automaticallyImplyLeading: false,
        title: Text(
          'Visitas',
          style: FlutterFlowTheme.of(context).title1,
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 120,
              height: 40,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).background,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 720,
                  child: BookAppointmentWidget(usuario: widget.usuario,),
                ),
              );
            },
          );
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: Icon(
          Icons.add_rounded,
          color: FlutterFlowTheme.of(context).textColor,
          size: 36,
        ),
      ),
      body: SafeArea(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(
                thickness: 3,
                indent: 150,
                endIndent: 150,
                color: Color(0xFF465056),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'Visitas pendientes.',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Text(
                  'Estas operando como:',
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 13),
                child: Text(
                  widget.usuario.nombre,
                  style: FlutterFlowTheme.of(context).subtitle1.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                ),
              ),
              listBook!=null ? Expanded(
                child:  ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: listBook.length,
                  itemBuilder: (context, listViewIndex) {
                    final evento =
                    listBook[listViewIndex];
                    return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(17, 0, 17, 13),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppointmentDetailsWidget(
                                      usuario: widget.usuario,
                                      booK: evento,
                                    ),
                              ),
                            );
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 91,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .darkBackground,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 12, 12, 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(4, 0, 0, 0),
                                            child: Text(
                                              evento.empresa,
                                              overflow: TextOverflow.ellipsis,
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .title3,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .grayLight,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          0, 8, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [

                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Text(
                                                evento.cliente,
                                                overflow: TextOverflow.ellipsis,
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyText1
                                                    .override(
                                                  fontFamily:
                                                  'Lexend Deca',
                                                  color: FlutterFlowTheme
                                                      .of(context)
                                                      .secondaryColor,
                                                ),
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
                        )
                    );
                  },
                ),

              ): Column(),
            ]
        ),
      ),
    );
  }
}