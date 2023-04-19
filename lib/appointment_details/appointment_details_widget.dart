import 'dart:async';
import 'dart:convert';

import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/components/coment_client_widget.dart';
import 'package:i_p_s_mant/models/book.dart';
import 'package:i_p_s_mant/models/catSeries.dart';
import 'package:i_p_s_mant/models/colaborador.dart';
import 'package:i_p_s_mant/models/requisitorEvento.dart';
import 'package:i_p_s_mant/models/serial.dart';
import 'package:i_p_s_mant/my_appointments/final_appointments_widget.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/edit_booking_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentDetailsWidget extends StatefulWidget {
  const AppointmentDetailsWidget({
    Key key,
    this.appointmentDetails, this.usuario, this.booK
  }) : super(key: key);
  final colaborador usuario ;
  final book booK;
  final requisitorEvento appointmentDetails;

  @override
  _AppointmentDetailsWidgetState createState() =>
      _AppointmentDetailsWidgetState();
}

class _AppointmentDetailsWidgetState extends State<AppointmentDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController serialNumberController;
  SharedPreferences preffs;
  List<serial> listSerial = [];

  catSeries serieEnCurso = catSeries();

  Location currentLocation = Location();
  String iLatitud;
  String iLongitud;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serialNumberController = TextEditingController();
    _getEnCurso();
    _getLocation();

  }
  _getEnCurso() async {
    int i = 1;
    preffs = await SharedPreferences.getInstance();
    String current = preffs.getString("currentSerie");
    DatabaseProvider.getCatSeriesbySerie(current).then((value) {
      setState(() {
        serieEnCurso = value;
      });
    });

  }

  _getSerial(String sr) async {
    _getLocation();
    _getEnCurso();
    preffs = await SharedPreferences.getInstance();
    //preffs.clear();
    // preffs.remove("currentSerie");

    String current = preffs.getString("currentSerie");
    serial guardaSerial = serial();
    String serials = preffs.getString(sr);

    print(sr);
    if(current == null || current == sr || current == "") {
      DatabaseProvider.getCatSeriesbySerie(sr).then((value) {
        catSeries serieultimo = catSeries();
        serieultimo = value;
        if (serieultimo != null) {
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AlertDialog(
                    title: Text("${sr}"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('EL NUMERO DE SERIE CORRESPONDE A: '),
                          Text("MODELO: " + serieultimo.modelo),
                          Text("MARCA: " + serieultimo.marca),
                          Text("CLIENTE: " + serieultimo.cliente)
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ), TextButton(
                        child: const Text('Aceptar'),
                        onPressed: () async {
                          print(serials);
                          print(current);

                          if (current == null) {
                            if (serials == null || serials == "") {
                              print("ENTRO A SERIALS: ::::::: :::: :::::: ");

                              guardaSerial.cliente = widget.booK.cliente;
                              guardaSerial.empresa = widget.booK.empresa;
                              guardaSerial.noserial = sr;
                              guardaSerial.estatus = "1";
                              final x = jsonEncode(guardaSerial);
                              print(x);
                              preffs.setString(sr, x);
                              preffs.setString("currentSerie", sr);

                              DatabaseProvider.postInsertaTicket(
                                  widget.usuario.usuario,
                                  widget.booK.empresa,
                                  "NA",
                                  widget.booK.cliente,
                                  widget.usuario.oficina,
                                  "IMPRESORA",
                                  "NA",
                                  "NA",
                                  sr,
                                  "NA",
                                  "NA",
                                  '3',
                                  widget.booK.tipo,
                                  'NA',
                                  "6",
                                  iLatitud,
                                  iLongitud).then((value) {

                              }
                              );
                            } else {
                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AlertDialog(
                                        title: const Text('ERROR'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text(
                                                  'EL NUMERO DE SERIE TERMINO'),
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
                                      ),
                                ),
                              );
                            }
                          } else {
                            if (current.trim() == sr.trim()) {
                              print("NO ENTRO A SERIALS: ::::::: :::: :::::: ");
                              String temp = preffs.getString(sr);
                              final parsed = json.decode(temp).cast<
                                  String,
                                  dynamic>();
                              serial listTemp = serial.fromJson(parsed);
                              print(listTemp.estatus);
                              if (listTemp.estatus != "1") {
                                print(
                                    "ENTRO A ESTATUS 1: ::::::: :::: :::::: ");
                                return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AlertDialog(
                                          title: const Text('ERROR'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const <Widget>[
                                                Text(
                                                    'EL NUMERO DE SERIE TERMINO'),
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
                                        ),
                                  ),
                                );
                              } else {
                                print(
                                    "NO ENTRO A ESTATUS 1: ::::::: :::: :::::: ");
                                if (current == sr) {
                                  print(
                                      "ENTRO A CURRENT == SERIE: ::::::: :::: :::::: ");
                                  _getCurrentSerial(listTemp);
                                } else {
                                  print(
                                      "NO ENTRO ENTRO A CURRENT == SERIE: ::::::: :::: :::::: ");
                                  print(sr);
                                  print(current);

                                  return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AlertDialog(
                                            title: const Text('ERROOR'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text(
                                                      'EL NUMERO DE SERIE NO CORRESPONDE AL ACTUAL'),
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
                                          ),
                                    ),
                                  );
                                }
                              }
                            } else {
                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AlertDialog(
                                        title: const Text('ERROR'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text(
                                                  'EL NUMERO DE SERIE NO CORRESPONDE AL ACTUAL'),
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
                                      ),
                                ),
                              );
                            }
                          }


                          return Navigator.of(context).pop();
                        },


                      ),
                    ],
                  ),
            ),
          );
        }
      }).onError((error, stackTrace) {
        if (current == null || current == sr || current == "") {
          serial guardaSerial = serial();
          String serials = preffs.getString(sr);
          print(serials);
          if (serials == null || serials == "") {
            _getLocation();

            guardaSerial.cliente = widget.booK.cliente;
            guardaSerial.empresa = widget.booK.empresa;
            guardaSerial.noserial = sr;
            guardaSerial.estatus = "1";
            final x = jsonEncode(guardaSerial);
            print(x);
            preffs.setString(sr, x);
            preffs.setString("currentSerie", sr);
            DatabaseProvider.postInsertaTicket(
                widget.usuario.usuario,
                widget.booK.empresa,
                "NA",
                widget.booK.cliente,
                widget.usuario.oficina,
                "IMPRESORA",
                "NA",
                "NA",
                sr,
                "NA",
                "NA",
                '3',
                "SOPORTEENCAMPO",
                'NA',
                "6",
                iLatitud,
                iLongitud).then((value) {

            }

            );
          } else {
            String temp = preffs.getString(sr);
            setState(() {
              print(temp);
              final parsed = json.decode(temp).cast<String, dynamic>();
              serial listTemp = serial.fromJson(parsed);
              print(listTemp.estatus);
              if (listTemp.estatus != "1") {
                return Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AlertDialog(
                          title: const Text('ERROR'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('EL NUMERO DE SERIE TERMINO'),
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
                        ),
                  ),
                );
              } else {
                _getCurrentSerial(listTemp);
              }
            });
          }
        } else {
          return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AlertDialog(
                    title: const Text('ERROOR'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text(
                              'EL NUMERO DE SERIE NO CORRESPONDE AL ACTUAL MANTENIMIENTO: '),
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
                  ),
            ),
          );
        }
      });
    }else{
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AlertDialog(
                title: const Text('ERROOR'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text(
                          'EL NUMERO DE SERIE NO CORRESPONDE AL ACTUAL MANTENIMIENTO: '),
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
              ),
        ),
      );
    }
    _getEnCurso();

  }
  static List<serial>  parseSerial(String responseBody) {
    final parsed = json.decode(responseBody).cast<String,dynamic>();
    return parsed.List<serial>((json) => serial.fromJson(json)).toList();
  }

  _getCurrentSerial(serial serie){

    DatabaseProvider.getDetalleSerie(serie.noserial, widget.usuario.usuario).then((detalle) {
      DatabaseProvider.getEstatusDetalleEventoById(detalle.id.toString()).then((estatus)  {
        print(estatus.id.toString());
        DatabaseProvider.getRequisitorEventoById(detalle.idEvento.toString()).then((value) async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditBookingWidget(usuario: widget.usuario, appointmentDetails: value, serie: serie, booK: widget.booK),
            ),
          );});

      }
      );
    });
  }

  _getLocation() async {
    var location = await currentLocation.getLocation();

    setState(() {
      iLatitud = location.latitude.toString();
      iLongitud = location.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Timer.periodic(Duration(seconds: 20), (timer) {
    //   _getEnCurso();
    // });
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).background,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: FlutterFlowTheme.of(context).grayLight,
            size: 32,
          ),
        ),
        title: Text(
          'Detalles',
          style: FlutterFlowTheme.of(context).title3,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: TextFormField(
                  onEditingComplete: (){
                    _getLocation();
                    print(serialNumberController.text);
                    _getLocation();
                    _getSerial(serialNumberController.text);
                    serialNumberController.clear();
                    _getEnCurso();
                  },
                  controller: serialNumberController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.characters,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Numero de Serie',
                    labelStyle: FlutterFlowTheme.of(context).bodyText1,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).background,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).background,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).darkBackground,
                    contentPadding:
                    EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  ),
                  style: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Mantenimiento',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      widget.booK.empresa,
                      style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Lexend Deca',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Para',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Expanded( child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .88,
                      height: 70,
                      decoration: BoxDecoration(
                        color:
                        FlutterFlowTheme.of(context).darkBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded( child:
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    widget.booK.cliente,
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .subtitle1
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .textColor,
                                    ),
                                  ),
                                ],
                              ),
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Mantenimiento en curso: ',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            serieEnCurso.numeroSerie!= null ?Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Expanded( child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .88,
                      height: 70,
                      decoration: BoxDecoration(
                        color:
                        FlutterFlowTheme.of(context).darkBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [


                            Expanded( child:
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    serieEnCurso.numeroSerie,
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .subtitle1
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .textColor,
                                    ),
                                  ),
                                  Text(
                                    serieEnCurso.marca+" - "+serieEnCurso.modelo,
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .subtitle1
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .textColor,
                                    ),
                                  ),

                                ],
                              ),
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
            ): Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Expanded( child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .88,
                      height: 70,
                      decoration: BoxDecoration(
                        color:
                        FlutterFlowTheme.of(context).darkBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10, 0, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [


                            Expanded( child:
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    "No Existe",
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .subtitle1
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .textColor,
                                    ),
                                  ),
                                  Text(
                                    "",
                                    overflow: TextOverflow.ellipsis,
                                    style: FlutterFlowTheme.of(
                                        context)
                                        .subtitle1
                                        .override(
                                      fontFamily: 'Lexend Deca',
                                      color:
                                      FlutterFlowTheme.of(
                                          context)
                                          .textColor,
                                    ),
                                  ),

                                ],
                              ),
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 36),
              child: FFButtonWidget(
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: 720,
                          child: FinalAppointmentsWidget(usuario: widget.usuario, booK: widget.booK,),
                        ),
                      );
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
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 36),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: 'Pausar',
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
          ],
        ),
      ),
    );
  }
}