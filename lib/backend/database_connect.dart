import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:i_p_s_mant/models/catClientes.dart';
import 'package:i_p_s_mant/models/catEmpresa.dart';
import 'package:i_p_s_mant/models/catEquipo.dart';
import 'package:i_p_s_mant/models/catMarca.dart';
import 'package:i_p_s_mant/models/catModelo.dart';
import 'package:i_p_s_mant/models/catSeries.dart';
import 'package:i_p_s_mant/models/catcategorias.dart';
import 'package:i_p_s_mant/models/colaborador.dart';
import 'package:i_p_s_mant/models/detalleEvento.dart';
import 'package:i_p_s_mant/models/estatusDetalleEvento.dart';
import 'package:i_p_s_mant/models/requisitorEvento.dart';
import 'package:i_p_s_mant/models/serviciosFotografias.dart';


class DatabaseProvider {
  static const ROOT = "http://104.215.117.162:8080/api/";
  static const ROOTCOLABORADORES = ROOT+"Colaborador/validausuario";
  static const ROOTCOLABORADORID = ROOT+"Colaborador/validausuarioid";
  static const ROOTINSERTATICKET = ROOT+"insertaTicketAsesor";
  static const ROOTDETALLEEVENTOID = ROOT+"detalleEvento/byid";
  static const ROOTDETALLEEVENTOIDEVENTO = ROOT+"detalleEvento/byeventoid";
  static const ROOTDETALLEEVENTOSERIE = ROOT+"detalleEvento/byserial";
  static const ROOTESTATUSDETALLEEVENTOID = ROOT+"estatusDetalle/byid";
  static const ROOTESTATUSDETALLEEVENTOASESOR = ROOT+"estatusDetalle/byasesor";
  static const ROOTEREQUISITOREVENTOID = ROOT+"RequisitorEvento/byid";
  static const ROOTCATCLIENTES = ROOT+"catClientes";
  static const ROOTCATCLIENTESBYID = ROOT+"catClientes/byid";
  static const ROOTCATCLIENTESBYIDEMPRESA = ROOT+"catClientes/byidempresa";
  static const ROOTCATEMPRESAS = ROOT+"catEmpresa";
  static const ROOTCATEMPRESASBYID = ROOT+"catEmpresa/byid";
  static const ROOTCATEMPRESASBYNOMBRE = ROOT+"catEmpresa/bynombre";
  static const ROOTCATEQUIPOS = ROOT+"catEquipos";
  static const ROOTCATMARCAS = ROOT+"catMarcas";
  static const ROOTCATMODELOS = ROOT+"catModelo";
  static const ROOTCATMODELOSBYMARCAID = ROOT+"catModelo/bymarca";
  static const ROOTCATCATEGORIAS = ROOT+"catCategorias";
  static const ROOTSATISFACCIONCLIENTE = ROOT+"satisfaccionCliente";
  static const ROOTFIN = ROOT+"estatusTicketTerminado";
  static const ROOTCATSERIESBYSERIE = ROOT+"catSeries/byserie";
  static const ROOTSERVICIOSFOTOBYIDEVENTO = ROOT+"servicioFotografias/byidevento";
  static const ROOTSERVICIOSFOTOSUBIR = ROOT+"servicioFotografias/insertar";






//----------------------------------------------------------
// SECTION OF USUARIO
//----------------------------------------------------------


//obtener usuario mediante email y password
  static Future<colaborador> getUserByEmailPassword(String user, String password) async {
    print(user);
    print(ROOTCOLABORADORES+"?user=${user}&password=${password}");
    var response = await http.get(Uri.parse(ROOTCOLABORADORES+"?user=${user}&password=${password}"));
    if (response.statusCode == 200) {
      colaborador list = colaborador.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <colaborador>[];
    }
  }
  //obtener usuario mediante id
  static Future<colaborador> getUserById(String id) async {
    print(id);
    print(ROOTCOLABORADORID+"?id=${id}");
    var response = await http.get(Uri.parse(ROOTCOLABORADORES+"?user=${id}"));
    print("RESPONSE BODY VALIDA USUARIO ID ::: "+response.body);
    if (response.statusCode == 200) {
      colaborador list = colaborador.fromJson(json.decode(response.body));

      return list;
    } else {
      colaborador list;
      return list;
    }
  }


//----------------------------------------------------------
// END SECTION OF USUARIO
//----------------------------------------------------------

//----------------------------------------------------------
// SECTION OF INSERTATICKET
//----------------------------------------------------------


//obtener usuario mediante email y password
  static Future<String> postInsertaTicket(String asesor, String email, String nombre, String empresa, String oficina, String tipoEquipo, String modelo, String marca, String numeroSerie, String accesorios, String falla, String prioridad, String asunto, String po, String tipoServicio, String iLatitud, String iLongitud) async {
    String root = ROOTINSERTATICKET+"?asesor=${asesor}&email=${email}&nombre=${nombre}&empresa=${empresa}&oficina=${oficina}&tipoEquipo=${tipoEquipo}&modelo=${modelo}&marca=${marca}&numeroSerie='${numeroSerie}'&accesorios=${accesorios}&falla=${falla}&prioridad=${prioridad}&asunto=${asunto}&po=${po}&tipoServicio=${tipoServicio}&iLatitud=${iLatitud}&iLongitud=${iLongitud}";
    final pattern = RegExp('\\s+');
    root = root.replaceAll(pattern, '');
    print(root);
    var response = await http.get(Uri.parse(root));
    if (response.statusCode == 200) {
      String list = response.statusCode.toString();

      return list;
    } else {
      String list = response.statusCode.toString();
      return list;
    }
  }


//----------------------------------------------------------
// END SECTION OF INSERTATICKET
//----------------------------------------------------------

//----------------------------------------------------------
// SECTION OF DETALLE EVENTO
//----------------------------------------------------------


//obtener usuario mediante email y password
  static Future<detalleEvento> getDetalleEventoById(String id) async {
    print(ROOTDETALLEEVENTOID+"?id=${id}");
    var response = await http.get(Uri.parse(ROOTDETALLEEVENTOID+"?id=${id}"));
    if (response.statusCode == 200) {
      detalleEvento list = detalleEvento.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <detalleEvento>[];
    }
  }
  //obtener usuario mediante email y password
  static Future<detalleEvento> getDetalleEventoByIdEvento(String id) async {
    print(ROOTDETALLEEVENTOIDEVENTO+"?id=${id}");
    var response = await http.get(Uri.parse(ROOTDETALLEEVENTOIDEVENTO+"?id=${id}"));
    if (response.statusCode == 200) {
      detalleEvento list = detalleEvento.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <detalleEvento>[];
    }
  }

  //obtener usuario mediante email y password
  static Future<detalleEvento> getDetalleSerie(String serie, String asesor) async {
    print(ROOTDETALLEEVENTOSERIE+"?serie=${serie}&asesor=${asesor}");
    var response = await http.get(Uri.parse(ROOTDETALLEEVENTOSERIE+"?serie=${serie}&asesor=${asesor}"));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<String,dynamic>();
      detalleEvento listTemp = detalleEvento.fromJson(parsed);
      detalleEvento  list = listTemp;
      return list;
    } else {
      detalleEvento  list = detalleEvento();
      return list;
    }
  }
  static List<detalleEvento> parseDetalle(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<detalleEvento>((json) => detalleEvento.fromJson(json)).toList();
  }


//----------------------------------------------------------
// END SECTION OF DETALLE EVENTO
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF ESTATUS DETALLE EVENTO
//----------------------------------------------------------


//obtener usuario mediante email y password
  static Future<estatusDetalleEvento> getEstatusDetalleEventoById(String id) async {
    print(ROOTESTATUSDETALLEEVENTOID+"?id=${id}");
    var response = await http.get(Uri.parse(ROOTESTATUSDETALLEEVENTOID+"?id=${id}"));
    if (response.statusCode == 200) {
      estatusDetalleEvento list = estatusDetalleEvento.fromJson(json.decode(response.body));

      return list;
    } else {
      estatusDetalleEvento list;

      return list;
    }
  }

  //obtener usuario mediante email y password
  static Future<List<estatusDetalleEvento>> getEstatusDetalleEventoByAsesor(String asesor) async {
    print(ROOTESTATUSDETALLEEVENTOASESOR+"?asesor=${asesor}");
    var response = await http.get(Uri.parse(ROOTESTATUSDETALLEEVENTOASESOR+"?asesor=${asesor}"));
    print(response.body);
    if (response.statusCode == 200) {
      List<estatusDetalleEvento>  list = parseDetalleEvento(response.body);

      return list;
    } else {
      throw <estatusDetalleEvento>[];
    }
  }
  static List<estatusDetalleEvento> parseDetalleEvento(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<estatusDetalleEvento>((json) => estatusDetalleEvento.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF ESTATUS DETALLE EVENTO
//----------------------------------------------------------
//----------------------------------------------------------
  // SECTION OF REQUISITOR EVENTO
//----------------------------------------------------------


//obtener usuario mediante email y password
  static Future<requisitorEvento> getRequisitorEventoById(String id) async {
    print(ROOTEREQUISITOREVENTOID+"?id=${id}");
    var response = await http.get(Uri.parse(ROOTEREQUISITOREVENTOID+"?id=${id}"));
    if (response.statusCode == 200) {
      requisitorEvento list = requisitorEvento.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <requisitorEvento>[];
    }
  }


//----------------------------------------------------------
// END SECTION OF REQUISITOR EVENTO
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF ESTATUS CATALOGO EMPRESAS
//----------------------------------------------------------


//obtener catalogo empresa por id
  static Future<catEmpresa> getCatEmpresasByID(String id) async {

    var response = await http.get(Uri.parse(ROOTCATEMPRESASBYID+"?id=${id}"));
    if (response.statusCode == 200) {
      catEmpresa list = catEmpresa.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <catEmpresa>[];
    }
  }
  //obtener catalogo empresa por id
  static Future<catEmpresa> getCatEmpresasByNombre(String nombre) async {

    var response = await http.get(Uri.parse(ROOTCATEMPRESASBYNOMBRE+"?nombre=${nombre}"));
    if (response.statusCode == 200) {
      catEmpresa list = catEmpresa.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <catEmpresa>[];
    }
  }
  //obtener catalogo empresa por id
  static Future<List<catEmpresa>> getCatEmpresas() async {

    var response = await http.get(Uri.parse(ROOTCATEMPRESAS));
    if (response.statusCode == 200) {
      List<catEmpresa> list = parseCatEmpresas(response.body);

      return list;
    } else {
      throw <catEmpresa>[];
    }
  }
  static List<catEmpresa> parseCatEmpresas(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<catEmpresa>((json) => catEmpresa.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF CATALOGO EMPRESAS
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF ESTATUS CATALOGO CLIENTES
//----------------------------------------------------------


//obtener catalogo clientes por id
  static Future<catCliente> getCatClientesByID(String id) async {

    var response = await http.get(Uri.parse(ROOTCATCLIENTESBYID+"?id=${id}"));
    if (response.statusCode == 200) {
      catCliente list = catCliente.fromJson(json.decode(response.body));

      return list;
    } else {
      throw <catCliente>[];
    }
  }
  //obtener catalogo clientes por id empresa
  static Future<List<catCliente>> getCatClientesByIDEmpresa(String id) async {

    var response = await http.get(Uri.parse(ROOTCATCLIENTESBYIDEMPRESA+"?id=${id}"));
    if (response.statusCode == 200) {
      List<catCliente> list = parseCatCliente(response.body);

      return list;
    } else {
      throw <catCliente>[];
    }
  }
  //obtener catalogo clienes
  static Future<List<catCliente>> getCatClientes() async {

    var response = await http.get(Uri.parse(ROOTCATCLIENTES));
    if (response.statusCode == 200) {
      List<catCliente> list = parseCatCliente(response.body);

      return list;
    } else {
      throw <catCliente>[];
    }
  }
  static List<catCliente> parseCatCliente(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<catCliente>((json) => catCliente.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF CATALOGO CLIENTES
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF ESTATUS CATALOGO MARCAS
//----------------------------------------------------------


//obtener catalogo clientes por id
  static Future<List<catMarca>> getCatMarcas() async {
    print(ROOTCATMARCAS);
    var response = await http.get(Uri.parse(ROOTCATMARCAS));
    if (response.statusCode == 200) {
      List<catMarca> list = parseCatMarca(response.body);

      return list;
    } else {
      throw <catCliente>[];
    }
  }

  //obtener catalogo clientes por id
  static Future<List<catMarca>> getCatMarcasbyNombre(String nombre) async {
    print(ROOTCATMARCAS);
    var response = await http.get(Uri.parse(ROOTCATMARCAS+"/bymarca?marca=${nombre}"));
    if (response.statusCode == 200) {
      List<catMarca> list = parseCatMarca(response.body);

      return list;
    } else {
      throw <catCliente>[];
    }
  }

  static List<catMarca> parseCatMarca(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<catMarca>((json) => catMarca.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF CATALOGO MARCAS
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF ESTATUS CATALOGO EQUIPOS
//----------------------------------------------------------


//obtener catalogo clientes por id
  static Future<List<catEquipo>> getCatEquipos() async {
    print(ROOTCATEQUIPOS);
    var response = await http.get(Uri.parse(ROOTCATEQUIPOS));
    if (response.statusCode == 200) {
      List<catEquipo> list = parseCatEquipos(response.body);

      return list;
    } else {
      throw <catCliente>[];
    }
  }


  static List<catEquipo> parseCatEquipos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<catEquipo>((json) => catEquipo.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF CATALOGO EQUIPOS
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF ESTATUS CATALOGO MODELOS
//----------------------------------------------------------


//obtener catalogo clientes por id
  static Future<List<catModelo>> getCatModelosbyMarcaid(String id) async {
    print(ROOTCATEQUIPOS);
    var response = await http.get(Uri.parse(ROOTCATMODELOSBYMARCAID+"?id=${id}"));
    if (response.statusCode == 200) {
      List<catModelo> list = parseCatModelo(response.body);

      return list;
    } else {
      throw <catModelo>[];
    }
  }

  static List<catModelo> parseCatModelo(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<catModelo>((json) => catModelo.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF CATALOGO MODELOS
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF ESTATUS CATALOGO CATEGORIAS
//----------------------------------------------------------


//obtener catalogo clientes por id
  static Future<List<catCategorias>> getCatCategorias() async {
    print(ROOTCATEQUIPOS);
    var response = await http.get(Uri.parse(ROOTCATCATEGORIAS));
    if (response.statusCode == 200) {
      List<catCategorias> list = parseCatCategorias(response.body);

      return list;
    } else {
      throw <catModelo>[];
    }
  }

  static List<catCategorias> parseCatCategorias(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<catCategorias>((json) => catCategorias.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF CATALOGO CATEGORIAS
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF SATISFACCION CLIENTE
//----------------------------------------------------------


//obtener catalogo clientes por id
  static getSatisfaccionCliente(int id, int tiempo, int trato, int satisfaccion) async {
    print(ROOTSATISFACCIONCLIENTE+"?id=${id}&tiempo=${tiempo}&trato=${trato}&satisfaccion=${satisfaccion}");
    var response = await http.get(Uri.parse(ROOTSATISFACCIONCLIENTE+"?id=${id}&tiempo=${tiempo}&trato=${trato}&satisfaccion=${satisfaccion}"));

  }


//----------------------------------------------------------
// END SECTION OF SATISFACCION CLIENTE
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF ESTATUS CERRADO
//----------------------------------------------------------


//obtener catalogo clientes por id
  static Future<String> getEstatusCerrado(int id, int idDetalle, String usuario, String nota, int estatus, String fLatitud, String fLongitud) async {
    print(ROOTFIN+"?id=${id}&idDetalle=${idDetalle}&usuario=${usuario}&nota=${nota}&estatus=${estatus}&fLatitud=$fLatitud&fLongitud=${fLongitud}");
    var response = await http.get(Uri.parse(ROOTFIN+"?id=${id}&idDetalle=${idDetalle}&usuario=${usuario}&nota=${nota}&estatus=${estatus}&fLatitud=$fLatitud&fLongitud=${fLongitud}"));
    if (response.statusCode == 200) {

      return "listo";
    } else {
      throw "Falla";
    }
  }


//----------------------------------------------------------
// END SECTION OF ESTATUS CERRADO
//----------------------------------------------------------

//----------------------------------------------------------
// SECTION OF CATALOGO SERIALES
//----------------------------------------------------------


//obtener catalogo clientes por id
  static Future<catSeries> getCatSeriesbySerie(String serie) async {
    print(ROOTCATSERIESBYSERIE+"?serie=${serie}");
    var response = await http.get(Uri.parse(ROOTCATSERIESBYSERIE+"?serie=${serie}"));
    if (response.statusCode == 200) {

      final parsed = json.decode(response.body).cast<String,dynamic>();
      catSeries listTemp = catSeries.fromJson(parsed);
      catSeries  list = listTemp;

      return list;
    } else {
      throw <catModelo>[];
    }
  }

  static List<catSeries> parseSeries(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<catSeries>((json) => catSeries.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF CATALOGO SERIALES
//----------------------------------------------------------
//----------------------------------------------------------
// SECTION OF SERVICIOS FOTOGRAFIAS
//----------------------------------------------------------


//obtener catalogo clientes por id
  static Future<List<serviciosFotografias>> getFotografiasbyIdEvento(String idevento) async {
    print(ROOTSERVICIOSFOTOBYIDEVENTO+"?id=${idevento}");
    var response = await http.get(Uri.parse(ROOTSERVICIOSFOTOBYIDEVENTO+"?id=${idevento}"));
    if (response.statusCode == 200) {

      List<serviciosFotografias> list = parseFotografias(response.body);

      return list;
    } else {
      throw <catModelo>[];
    }
  }

//obtener catalogo clientes por id
  static Future<List<serviciosFotografias>> postFotografias(String idevento, String nombre, String contenido) async {
    http.MultipartRequest request = new http.MultipartRequest("POST",
        Uri.parse(ROOT+"Upload"));
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath('file', contenido);

    request.files.add(multipartFile);
    var headers = {
      "content-type" : "multipart/form-data"
    };
    request.headers.addAll(headers);
    String responseString = "";
    var respons = await request.send();
    if(respons.statusCode == 200){
      responseString = await respons.stream.bytesToString();
      print(responseString);
      var response = await http.get(Uri.parse(ROOTSERVICIOSFOTOSUBIR+"?idevento=${idevento}&nombre=${nombre}&contenido=${responseString}"));
      if (response.statusCode == 200) {

        List<serviciosFotografias> list = parseFotografias(response.body);

        return list;
      } else {
        throw <catModelo>[];
      }
    }else{
      return null;
    }


  }

  static List<serviciosFotografias> parseFotografias(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<serviciosFotografias>((json) => serviciosFotografias.fromJson(json)).toList();
  }

//----------------------------------------------------------
// END SECTION OF SERVICIOS FOTOGRAFIAS
//----------------------------------------------------------
}