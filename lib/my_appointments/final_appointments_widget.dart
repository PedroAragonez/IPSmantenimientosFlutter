import 'dart:convert';

import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/components/coment_client_widget.dart';
import 'package:i_p_s_mant/components/view_booking_widget.dart';
import 'package:i_p_s_mant/flutter_flow/flutter_flow_widgets.dart';
import 'package:i_p_s_mant/models/book.dart';
import 'package:i_p_s_mant/models/colaborador.dart';
import 'package:i_p_s_mant/models/detalleEvento.dart';
import 'package:i_p_s_mant/models/requisitorEvento.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appointment_details/appointment_details_widget.dart';
import '../components/book_appointment_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalAppointmentsWidget extends StatefulWidget {
  final colaborador usuario;
  final book booK;
  const FinalAppointmentsWidget({Key key, this.usuario, this.booK}) : super(key: key);

  @override
  _FinalAppointmentsWidgetState createState() => _FinalAppointmentsWidgetState();
}

class _FinalAppointmentsWidgetState extends State<FinalAppointmentsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<requisitorEvento> listaEventos = [];
  SharedPreferences preffs;
  List<book> listBook;
  List<detalleEvento> listDetalleEventos = [];
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
    List<String> listadeeventos = [];
    print(widget.booK.empresa+widget.booK.cliente);
    listadeeventos = preffs.getStringList(widget.booK.empresa+widget.booK.cliente);
    print(listadeeventos);

    if(listadeeventos!=null){
      listadeeventos.forEach((element) {
        print(element);
        DatabaseProvider.getRequisitorEventoById(element).then((requisitorEvento) {

          setState(() {
            listaEventos.add(requisitorEvento);
          });
          DatabaseProvider.getDetalleEventoByIdEvento(requisitorEvento.id.toString()).then((detalleEvento) {

            setState(() {
              listDetalleEventos.add(detalleEvento);
            });

          });


        });
      });
    }


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
          'Servicios',
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
              listDetalleEventos!=null || listaEventos!=[] ? Expanded(
                child:  ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: listDetalleEventos.length,
                  itemBuilder: (context, listViewIndex) {
                    final evento =
                    listDetalleEventos[listViewIndex];
                    return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(17, 0, 17, 13),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ViewBookingWidget(
                                      usuario: widget.usuario, detalleevento: evento, booK: widget.booK,
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
                                              evento.numeroSerie,
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
                                                evento.tipoEquipo,
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

              ): Text("NO SE REALIZO NINGUN SERVICIO"),
              listDetalleEventos!=null || listaEventos!=[]? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 36),
                child: FFButtonWidget(
                  onPressed: () async {
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        if(listDetalleEventos.isNotEmpty){
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Container(
                              height: 720,
                              child: ComentClientWidget(appointmentDetails: listaEventos, details: listDetalleEventos, booK: widget.booK,),
                            ),
                          );
                        }else{

                          return AlertDialog(
                            title: const Text('ERROR'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text(
                                      'NO SE REALIZARON MANTENIMIENTOS NI SOPORTES EN ESTE SERVICIO'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Aceptar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }

                      },
                    );
                  },
                  text: 'Terminar',
                  options: FFButtonOptions(
                    width: 300,
                    height: 60,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle:
                    FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: FlutterFlowTheme.of(context).textColor,
                      fontWeight: FontWeight.w600,
                    ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 8,
                  ),
                ),
              ) : Column(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 36),
                child: FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  text: 'Cancelar',
                  options: FFButtonOptions(
                    width: 230,
                    height: 50,
                    color: FlutterFlowTheme.of(context).darkBackground,
                    textStyle:
                    FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: FlutterFlowTheme.of(context).textColor,
                      fontWeight: FontWeight.w600,
                    ),
                    elevation: 2,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 8,
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}