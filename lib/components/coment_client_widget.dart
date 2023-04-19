import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:hand_signature/signature.dart';
import 'package:i_p_s_mant/backend/database_connect.dart';
import 'package:i_p_s_mant/models/book.dart';
import 'package:i_p_s_mant/models/detalleEvento.dart';
import 'package:i_p_s_mant/models/requisitorEvento.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_checkbox_group.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ComentClientWidget extends StatefulWidget {
  final List<requisitorEvento> appointmentDetails;
  final List<detalleEvento> details;
  final book booK;
  const ComentClientWidget({
    Key key, this.appointmentDetails, this.details, this.booK
  }) : super(key: key);


  @override
  _ComentClientWidgetState createState() => _ComentClientWidgetState();
}

class _ComentClientWidgetState extends State<ComentClientWidget> {
  List<String> checkboxGroupValues;
  TextEditingController textController;
  int tiempo = 0;
  int trato = 0;
  int satisfaccion = 0;
  SharedPreferences preffs;
  List<book> listaBook = [];
  Uint8List firma = null;
  ValueNotifier<ByteData> rawImage = ValueNotifier<ByteData>(null);
  HandSignatureControl control = new HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    print(widget.details[0].numeroSerie);
    print(widget.booK.empresa+widget.booK.cliente);
  }
  static List<book> parseBook(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<book>((json) => book.fromJson(json)).toList();
  }
  _satisfaccion() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final name = 'signature.png';
    firma  = rawImage.value.buffer.asUint8List();
    final result = await ImageGallerySaver.saveImage(firma, name: name);

    var path = await FlutterAbsolutePath.getAbsolutePath(result['filePath']);


    preffs = await SharedPreferences.getInstance();

    widget.appointmentDetails.forEach((element) {

      DatabaseProvider.getSatisfaccionCliente(element.id, tiempo, trato, satisfaccion).then((value) {

      });
      DatabaseProvider.postFotografias(element.id.toString(), "firma", path).then((value) {

      });

    });
    String temp = preffs.getString("listaBook");
    print(temp);

    widget.details.forEach((element) {
      print("NUMERO DE SERIE A BORRAR."+element.numeroSerie+".");
      preffs.remove(element.numeroSerie.trim());
    });
    String nombre = widget.booK.empresa+widget.booK.cliente;
    preffs.remove(nombre);
    preffs.setStringList(widget.booK.empresa+widget.booK.cliente, []);
    print(preffs.getStringList(widget.booK.empresa+widget.booK.cliente));

    if(temp!=null){
      List<book> temporalBook = parseBook(temp);
      temporalBook.forEach((element) {
        if(element.empresa==widget.booK.empresa){
          if(element.cliente==widget.booK.cliente){
            temporalBook.removeWhere((elements) => elements == element);
            print(element.empresa);
            listaBook = temporalBook;
            final x =  jsonEncode(temporalBook);
            print("LISTABOOK::::::::: "+x);
            preffs.setString("listaBook", x);
          }else{
            print("la empresa se ah utilizado");
          }

        }
      });
    }



  }



  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'Califica tu servicio',
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
                        'La información permanecera confidencial',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'Califica Tiempo',
                        style: FlutterFlowTheme.of(context).title1,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    tiempo!=1 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSadTear,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            tiempo=1;
                          });
                        },
                      ),
                    ): Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.red,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSadTear,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            tiempo=1;
                          });
                        },
                      ),
                    ),
                    tiempo!=2 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidMeh,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            tiempo = 2;
                          });
                        },
                      ),
                    ) : Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.yellow,
                        icon: FaIcon(
                          FontAwesomeIcons.solidMeh,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            tiempo = 2;
                          });

                        },
                      ),
                    ),
                    tiempo!=3 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSmileWink,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            tiempo = 3;
                          });
                        },
                      ),
                    ) : Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.green,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSmileWink,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            tiempo = 3;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
          Slider(
            min: 0.0,
            max: 10.0,
            // value: _value,
            // interval: 20,
            // showTicks: true,
            // showLabels: true,
            // enableTooltip: true,
            // minorTicksPerInterval: 1,
            // onChanged: (dynamic value){
            //   setState(() {
            //     _value = value;
            //   });
            // },
          ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'Califica Trato',
                        style: FlutterFlowTheme.of(context).title1,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    trato!=1 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSadTear,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            trato=1;
                          });
                        },
                      ),
                    ): Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.red,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSadTear,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            trato=1;
                          });
                        },
                      ),
                    ),
                    trato!=2 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidMeh,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            trato = 2;
                          });
                        },
                      ),
                    ) : Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.yellow,
                        icon: FaIcon(
                          FontAwesomeIcons.solidMeh,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            trato = 2;
                          });

                        },
                      ),
                    ),
                    trato!=3 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSmileWink,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            trato = 3;
                          });
                        },
                      ),
                    ) : Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.green,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSmileWink,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            trato = 3;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        'Califica Satisfaccion',
                        style: FlutterFlowTheme.of(context).title1,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    satisfaccion!=1 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSadTear,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            satisfaccion=1;
                          });
                        },
                      ),
                    ): Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.red,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSadTear,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            satisfaccion=1;
                          });
                        },
                      ),
                    ),
                    satisfaccion!=2 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidMeh,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            satisfaccion = 2;
                          });
                        },
                      ),
                    ) : Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.yellow,
                        icon: FaIcon(
                          FontAwesomeIcons.solidMeh,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            satisfaccion = 2;
                          });

                        },
                      ),
                    ),
                    satisfaccion!=3 ? Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: FlutterFlowTheme.of(context).background,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSmileWink,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            satisfaccion = 3;
                          });
                        },
                      ),
                    ) : Expanded(
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 60,
                        fillColor: Colors.green,
                        icon: FaIcon(
                          FontAwesomeIcons.solidSmileWink,
                          color: FlutterFlowTheme.of(context).textColor,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            satisfaccion = 3;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 2.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints.expand(),
                              color: Colors.white,
                              child: HandSignature(
                                control: control,
                                type: SignatureDrawType.shape,
                              ),
                            ),
                            CustomPaint(
                              painter: DebugSignaturePainterCP(
                                control: control,
                                cp: false,
                                cpStart: false,
                                cpEnd: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),],
                ),

              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: 'Cancelar',
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

                    FFButtonWidget(
                      onPressed: ()  async {


                        rawImage.value = await control.toImage(
                          color: Colors.blueAccent,
                          background: Colors.greenAccent,
                          fit: false,
                        );


                        print("AQUI SI");

                        _satisfaccion();

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);

                      },
                      text: 'Guardar',
                      options: FFButtonOptions(
                        width: 150,
                        height: 50,
                        color: FlutterFlowTheme.of(context).primaryColor,
                        textStyle:
                        FlutterFlowTheme.of(context).subtitle2.override(
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

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}