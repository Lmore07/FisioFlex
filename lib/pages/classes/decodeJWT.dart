import 'package:TeraFlex/pages/interfaces/loginInformationInterface.dart';
import 'package:jwt_decode/jwt_decode.dart';

LoginInformation decodificarToken(String token) {
  final decodedToken = Jwt.parseJwt(token);
  return LoginInformation.fromJson(decodedToken);
}
