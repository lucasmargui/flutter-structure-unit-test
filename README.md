<H1 align="center">Flutter Unit Test</H1>
<p align="center">🚀 Development of a framework containing mocktail for unit testing for future references</p>

## Resources Used
- Flutter 3.3.5
- Auth ^8.2.0+02
- Firebase_core 2.24.2
- Firebase_auth 4.16.0
- Mocktail 0.3.0



## Registration unit test

Comment for each function of the unit test code:

<div align="center">
 <img src="https://github.com/lucasmargui/Flutter_Estrutura_TesteUnitario/assets/157809964/0360f531-520b-415f-8107-c8517a32f218" style="width:70%">
</div>



```
test('Test signUp success', () async

```


- Start of the unit test that verifies the success of a user registration.


```
final mockUser = MockUser();

```

- Creates an instance of a mocked user to simulate a user's behavior during testing.


```
final expectedUser = UserModel(name: 'John', email: 'john@example.com', id: '123');

```

- Defines an expected user with specific information to check whether registration was successful.



```
when(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: any(named: 'email'), password: any(named: 'password'))).thenAnswer((_) async => MockUserCredential());

```

- Configures the behavior of the FirebaseAuth createUserWithEmailAndPassword method to return an instance of MockUserCredential when called.

```
when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

```

- Configures FirebaseAuth's currentUser method to return the mocked user mockUser.

```
when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async {});

```

- Configures the mocked user's updateDisplayName method to do nothing, just return an empty asynchronous operation.

```
when(() => mockFirebaseAuth.currentUser!.displayName).thenReturn('John');

```

- Sets the current user name in FirebaseAuth to 'John'.

```
when(() => mockFirebaseAuth.currentUser!.email).thenReturn('john@example.com');

```

- Configures the current user's email in FirebaseAuth as 'john@example.com'.

```
### when(() => mockFirebaseAuth.currentUser!.uid).thenReturn('123');

```

- Sets the current user's UID (unique identifier) ​​in FirebaseAuth to '123'.

```
when(() => mockFirebaseAuthService.signUp(name: 'User', email: 'user@email.com', password: 'user@123')).thenAnswer((_) async => expectedUser);

```

- Configures the Firebase authentication service's signUp method to return expectedUser when called with the specified parameters.

```
final result = await mockFirebaseAuthService.signUp(name: 'User', email: 'user@email.com', password: 'user@123');

```

- Calls the signUp method with test data and stores the result for verification.

```
expect(result.name, expectedUser.name);

```

- Checks whether the name returned after registration is the same as the expected name.

```
expect(result.email, expectedUser.email);

```

- Checks if the email returned after registration is the same as the expected email.

```
expect(result.id, expectedUser.id);

```

- Checks whether the ID returned after registration is the same as the expected ID.
