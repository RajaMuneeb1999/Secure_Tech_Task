

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:product_task/view_model/user_view_model.dart';

import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../respository/auth_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class LoginViewModel with ChangeNotifier {

  final _myRepo = LoginRepository();

  bool _loading = false ;
  bool get loading => _loading ;

  bool _signUpLoading = false ;
  bool get signUpLoading => _signUpLoading ;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data , BuildContext context) async {

    setLoading(true);

    _myRepo.loginApi(data).then((value){
      setLoading(false);
      final userPreference = Provider.of<UserViewModel>(context , listen: false);
      userPreference.saveUser(
        UserModel(
          token: value['token'].toString()
        )
      );

      Utils.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());

      }
    }).onError((error, stackTrace){
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }

    });
  }


}