// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_application/common/models/user_model.dart';

import '../mock/mock_classes.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuthService mockFirebaseAuthService;
  late MockFirebaseAuth mockFirebaseAuth;

  // Configurando a instância de simulação do FirebaseAuthService
  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseAuthService = MockFirebaseAuthService();
  });

// Adicionando um pouco mais de complexidade a esse código
// When =  tudo oq deve retornar quando método for chamado
  test('Test signUp success', () async {
    final mockUser = MockUser();
    final expectedUser =
        UserModel(name: 'John', email: 'john@example.com', id: '123');

    when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async => MockUserCredential());

    when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
    when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async {});

    when(() => mockFirebaseAuth.currentUser!.displayName).thenReturn('John');
    when(() => mockFirebaseAuth.currentUser!.email)
        .thenReturn('john@example.com');
    when(() => mockFirebaseAuth.currentUser!.uid).thenReturn('123');

    // Configurando o método signUp de mockFirebaseAuthService
    when(
      () => mockFirebaseAuthService.signUp(
          name: 'User', email: 'user@email.com', password: 'user@123'),
    ).thenAnswer(
      (_) async => expectedUser,
    );

    final result = await mockFirebaseAuthService.signUp(
        name: 'User', email: 'user@email.com', password: 'user@123');

    expect(result.name, expectedUser.name);
    expect(result.email, expectedUser.email);
    expect(result.id, expectedUser.id);
  });

  group('Firebase Authentication Tests', () {
    late FirebaseAuth firebaseAuth;

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
    });

    test('Testando login com e-mail e senha', () async {
      // Definindo o retorno esperado para o método signInWithEmailAndPassword
      when(() => firebaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) => Future.value(MockUserCredential()));

      // Executando o teste de login
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: 'test@example.com', password: 'password123');

      // Verificando se o login foi bem-sucedido
      expect(result, isA<UserCredential>());
    });
  });

  // Testando a funcionalidade de registro com um cenário de sucesso
  test('Teste de registro bem-sucedido', () async {
    // Criando um modelo de usuário para fins de teste

    // Um exemplo de como o dado deve retornar;
    final user =
        UserModel(name: 'User', email: 'user@email.com', id: '1a2b3c4d5e');

    //Configurando o método signUp de mockFirebaseAuthService
    //Ou seja, estamos simulando este método , configurando ele, passando oq deve estár na chamada da função e oq ela vai retornar
    //quando chamarmos o método signUp passando esses dados ele deverá retornar user
    when(
      () => mockFirebaseAuthService.signUp(
          name: 'User', email: 'user@email.com', password: 'user@123'),
    ).thenAnswer(
      (_) async => user,
    );

    // Chamando o método signUp com dados de teste e esperando um resultado
    final result = await mockFirebaseAuthService.signUp(
        name: 'User', email: 'user@email.com', password: 'user@123');

    // Verificando o resultado em relação ao modelo de usuário esperado
    expect(result, user);
  });
}
