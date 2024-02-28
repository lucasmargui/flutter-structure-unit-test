import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import '../common/models/user_model.dart';

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    // TODO: implement signIn
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result.user != null) {
        log('Usuário ${result.user!.displayName} logado com sucesso');
        //exclamação na frente de result.user! garante que user não é nulo
        return UserModel(
            name: result.user!.displayName,
            email: result.user!.email,
            id: result.user!.uid);
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "null";
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp(
      {String? name, required String email, required String password}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (result.user != null) {
        //exclamação na frente de result.user! garante que user não é nulo
        await result.user!.updateDisplayName(name);
        log("Usuário $name Registrado com sucesso");
        return UserModel(
            name: _auth.currentUser?.displayName,
            email: _auth.currentUser?.email,
            id: _auth.currentUser?.uid);
      } else {
        throw Exception();
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "null";
    } catch (e) {
      rethrow;
    }
  }
}
