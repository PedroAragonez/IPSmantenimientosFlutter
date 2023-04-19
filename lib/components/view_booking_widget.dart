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
import 'package:i_p_s_mant/models/estatusDetalleEvento.dart';
import 'package:i_p_s_mant/models/requisitorEvento.dart';
import 'package:i_p_s_mant/models/serial.dart';
import 'package:i_p_s_mant/models/serviciosFotografias.dart';
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

class ViewBookingWidget extends StatefulWidget {
  final requisitorEvento appointmentDetails;
  final detalleEvento detalleevento;
  final colaborador usuario ;
  final serial serie;
  final book booK;
  const ViewBookingWidget({
    Key key, this.appointmentDetails, this.usuario, this.serie, this.booK, this.detalleevento
  }) : super(key: key);


  @override
  _ViewBookingWidgetState createState() => _ViewBookingWidgetState();
}

class _ViewBookingWidgetState extends State<ViewBookingWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String dropDownValue;
  TextEditingController personsNameController;
  TextEditingController problemDescriptionController = new TextEditingController();
  String uploadedFileUrl = '';
  List<String> checkboxGroupValues;
  List<serviciosFotografias> imageList = [];
  estatusDetalleEvento estatusevento;
  String notas;
  List<String> checkBox;

  SharedPreferences preffs;
  List<catCategorias> listadeopcioness;
  @override
  void initState() {
    super.initState();
    _getFotografias();
    _getEstatusEvento();
  }


  _getFotografias(){
    DatabaseProvider.getFotografiasbyIdEvento(widget.detalleevento.idEvento.toString()).then((value) {
      setState(() {
        imageList = value;
      });
    });
  }
  _getEstatusEvento(){
    DatabaseProvider.getEstatusDetalleEventoById(widget.detalleevento.id.toString()).then((value) {
      estatusevento = value;
      notas = value.notas;
      notas = notas.replaceAll("^", " ");
      String notascopy = notas;

      checkBox = notascopy.split("~");
      notas = checkBox[0];
      checkBox.remove(0);
      checkBox.removeAt(0);

      setState(() {
        notas = notas;
        checkBox = checkBox;

      });
    });

  }




  @override
  Widget build(BuildContext context) {

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
                      "Cmentarios",
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  estatusevento != null ?Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Text(
                      notas,
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ) : Column(),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                    child: Text(
                      "Mantenimiento",
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  estatusevento != null ?Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Column(children:
                      List.generate(checkBox.length, (index) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.check_circle, size: 14, color: Colors.green,),
                              ),
                              TextSpan(
                                text: checkBox[index],
                              ),
                            ],
                          ),
                        );
                      }) ,
                      )
                  ) : Column(),


                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 12),
                    child: Text(
                      "Evidencia",
                      style: FlutterFlowTheme.of(context).subtitle1.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  imageList!=null ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 2,
                        height: 150,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(imageList.length, (index) {
                              return Expanded (child: Image.network("http://104.215.117.162:8080/images/"+imageList[index].contenido),);
                            }),
                          ),
                        ),
                      ),
                    ),
                  ) : Column(),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded ( child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: 'Volver',
                          options: FFButtonOptions(
                            width: 100,
                            height: 50,
                            color: FlutterFlowTheme.of(context).background,
                            textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
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