import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/components/coment_client_widget.dart';
import 'package:i_p_s_mant/flutter_flow/flutter_flow_checkbox_group.dart';
import 'package:i_p_s_mant/models/book.dart';
import 'package:i_p_s_mant/models/catcategorias.dart';
import 'package:i_p_s_mant/models/colaborador.dart';
import 'package:i_p_s_mant/models/detalleEvento.dart';
import 'package:i_p_s_mant/models/requisitorEvento.dart';
import 'package:i_p_s_mant/models/serial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/param_booking_widget.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBookingWidget extends StatefulWidget {
  final requisitorEvento appointmentDetails;
  final colaborador usuario;
  final serial serie;
  final book booK;
  const EditBookingWidget(
      {Key key, this.appointmentDetails, this.usuario, this.serie, this.booK})
      : super(key: key);

  @override
  _EditBookingWidgetState createState() => _EditBookingWidgetState();
}

class _EditBookingWidgetState extends State<EditBookingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String dropDownValue;
  TextEditingController personsNameController;
  TextEditingController problemDescriptionController;
  String uploadedFileUrl = '';
  List<String> checkboxGroupValues = [];
  List<File> imageList = [];
  Location currentLocation = Location();
  String iLatitud = "";
  String iLongitud = "";
  detalleEvento detalleEventoActual;

  SharedPreferences preffs;
  List<catCategorias> listadeopcioness;
  @override
  void initState() {
    super.initState();
    _checkBox();
    _getLocation();
    _getDetalleEvento();
    problemDescriptionController = new TextEditingController();
    currentLocation = Location();

  }

  _getDetalleEvento() {
    DatabaseProvider.getDetalleEventoByIdEvento(
        widget.appointmentDetails.id.toString())
        .then((value) {
      setState(() {
        detalleEventoActual = value;
      });
    });
  }

  _checkBox() {
    DatabaseProvider.getCatCategorias().then((value) {
      print("TIPO DE SOPORTE::: "+widget.booK.tipo);
      setState(() {
        if(widget.booK.tipo.contains("SOPORTEENCAMPO")){
          value.forEach((element) {
            checkboxGroupValues.add(element.desCorta.trim());
          });
          listadeopcioness = null;
        }else{
          listadeopcioness = value;
        }
      });
    });

  }

  _final() async {
    _getLocation();
    preffs = await SharedPreferences.getInstance();
    List<String> listadeeventos = [];
    String nombre = widget.booK.empresa + widget.booK.cliente;
    listadeeventos = preffs.getStringList(nombre);


    if (listadeeventos == null) {
      listadeeventos = [];
    }


    listadeeventos.add(widget.appointmentDetails.id.toString());

    serial guardaSerial = serial();
    guardaSerial = widget.serie;
    print(guardaSerial.estatus);
    guardaSerial.estatus = "3";
    final x = jsonEncode(guardaSerial);
    print(x);
    preffs.setString(widget.serie.noserial, x);
    preffs.remove("currentSerie");
    _getLocation();
    String note;
    print(problemDescriptionController.text);
    if (problemDescriptionController.text != "") {
      note = problemDescriptionController.text;
    } else {
      note = "NA";
    }

    checkboxGroupValues.forEach((element) {
      note = note + "~" + element;
    });
    note = note.replaceAll(" ", "");
    note = note.replaceAll("\n", "^");
    String usuario = widget.usuario.usuario;
    usuario = usuario.replaceAll(" ", "");
    usuario = usuario.replaceAll("\n", "^");

    preffs.setStringList(nombre, listadeeventos);
    DatabaseProvider.getEstatusCerrado(widget.appointmentDetails.id,
        detalleEventoActual.id, usuario, note, 2, iLatitud, iLongitud)
        .then((value) {});
  }

  _getLocation() async {
    var location = await currentLocation.getLocation();

    iLatitud = location.latitude.toString();
    iLongitud = location.longitude.toString();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (image == null) return;

      Uint8List imagebytes = await Io.File(image.path).readAsBytesSync();
      String img64 = base64Encode(imagebytes);
      img64 = img64.replaceAll("/", "%2F");
      setState(() {
        imageList.add(File(image.path));
        DatabaseProvider.postFotografias(
            widget.appointmentDetails.id.toString(), "despues", image.path)
            .then((value) {});
      });
    } on PlatformException catch (e) {
      print("Fallo al cargar imagen: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String email;
    if (widget.appointmentDetails.email != null) {
      email = widget.appointmentDetails.email;
    } else {
      email = "No existe correo";
    }
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
          'Registro',
          style: FlutterFlowTheme.of(context).title3,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).background,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).darkBackground,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    thickness: 3,
                    indent: 150,
                    endIndent: 150,
                    color: Color(0xFF465056),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Text(
                      'Iniciar',
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text(
                            'Descripcion del proceso',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      'La informacion sera enviada a :',
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                    child: Text(
                      email,
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: TextFormField(
                      controller: problemDescriptionController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Comentario',
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
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).textColor,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),

                  listadeopcioness != null
                      ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Expanded(child: Material(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color:
                          FlutterFlowTheme.of(context).darkBackground,
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color:
                            FlutterFlowTheme.of(context).background,
                            width: 2,
                          ),
                        ),
                        child: FlutterFlowCheckboxGroup(
                          initiallySelected: checkboxGroupValues != null
                              ? checkboxGroupValues
                              : [],
                          options: new List.generate(
                              listadeopcioness.length,
                                  (index) =>
                                  listadeopcioness[index].desCorta.trim()),
                          onChanged: (val) => setState(() {
                            checkboxGroupValues = val;
                          }),
                          activeColor:
                          FlutterFlowTheme.of(context).primaryColor,
                          checkColor: Colors.white,
                          checkboxBorderColor: Color(0xFF95A1AC),
                          textStyle:
                          FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                    ),
                    ),
                  )
                      : Column(),
                  imageList != null
                      ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 60,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              50, 0, 50, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children:
                            List.generate(imageList.length, (index) {
                              return Expanded(
                                child: Image.file(imageList[index]),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  )
                      : Column(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 60,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30,
                                  buttonSize: 46,
                                  fillColor: Color(0xFF1D3AC7),
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () async {
                                    pickImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            text: 'Cancelar',
                            options: FFButtonOptions(
                              width: 100,
                              height: 50,
                              color: FlutterFlowTheme.of(context).background,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 8,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FFButtonWidget(
                            onPressed: () {
                              _final();
                              Navigator.pop(context);
                            },
                            text: 'Terminar',
                            options: FFButtonOptions(
                              width: 150,
                              height: 50,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}