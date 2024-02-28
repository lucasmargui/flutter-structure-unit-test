<H1 align="center">Flutter Teste Unitário</H1>
<p align="center">🚀 Desenvolvimento de uma estrutura contendo mocktail para teste unitário para referências futuras</p>

## Recursos Utilizados
- Flutter 3.3.5
- Auth ^8.2.0+02
- Firebase_core 2.24.2
- Firebase_auth 4.16.0
- Mocktail 0.3.0



## Teste unitário de cadastro

Comentário para cada função do código de teste unitário:

<div align="center">
  <img src="https://github.com/lucasmargui/Flutter_Estrutura_TesteUnitario/assets/157809964/0360f531-520b-415f-8107-c8517a32f218" style="width:70%">
</div>



```
test('Test signUp success', () async 

```


- Início do teste unitário que verifica o sucesso do registro de um usuário.


```
final mockUser = MockUser();

```

- Cria uma instância de um usuário mockado para simular o comportamento de um usuário durante o teste.


```
final expectedUser = UserModel(name: 'John', email: 'john@example.com', id: '123');

```

- Define um usuário esperado com informações específicas para verificar se o registro foi bem-sucedido.
  


```
when(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: any(named: 'email'), password: any(named: 'password'))).thenAnswer((_) async => MockUserCredential());

```

- Configura o comportamento do método createUserWithEmailAndPassword do FirebaseAuth para retornar uma instância de MockUserCredential quando chamado.

```
when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

```

- Configura o método currentUser do FirebaseAuth para retornar o usuário mockado mockUser.

```
when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async {});

```

- Configura o método updateDisplayName do usuário mockado para não fazer nada, apenas retornar uma operação assíncrona vazia.

```
when(() => mockFirebaseAuth.currentUser!.displayName).thenReturn('John');

```

- Configura o nome do usuário atual no FirebaseAuth como 'John'.

```
when(() => mockFirebaseAuth.currentUser!.email).thenReturn('john@example.com');

```

- Configura o e-mail do usuário atual no FirebaseAuth como 'john@example.com'.

```
### when(() => mockFirebaseAuth.currentUser!.uid).thenReturn('123');

```

- Configura o UID (identificador único) do usuário atual no FirebaseAuth como '123'.

```
when(() => mockFirebaseAuthService.signUp(name: 'User', email: 'user@email.com', password: 'user@123')).thenAnswer((_) async => expectedUser);

```

- Configura o método signUp do serviço de autenticação do Firebase para retornar expectedUser quando chamado com os parâmetros especificados.

```
final result = await mockFirebaseAuthService.signUp(name: 'User', email: 'user@email.com', password: 'user@123');

```

- Chama o método signUp com dados de teste e armazena o resultado para verificação.

```
expect(result.name, expectedUser.name);

```

- Verifica se o nome retornado após o registro é igual ao nome esperado.

```
expect(result.email, expectedUser.email);

```

- Verifica se o e-mail retornado após o registro é igual ao e-mail esperado.

```
expect(result.id, expectedUser.id);

```

- Verifica se o ID retornado após o registro é igual ao ID esperado.





