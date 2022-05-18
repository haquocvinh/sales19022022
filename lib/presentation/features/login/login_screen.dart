import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phanam/common/app_constant.dart';
import 'package:phanam/data/remote/request/authentication_request.dart';
import 'package:phanam/data/repository/authentication_repository.dart';
import 'package:phanam/presentation/features/login/bloc/login_bloc.dart';
import 'package:phanam/presentation/features/login/bloc/login_event.dart';
import 'package:phanam/presentation/features/login/bloc/login_state.dart';
import 'package:phanam/presentation/widget/loading_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthenticationRequest()),
        ProxyProvider<AuthenticationRequest, AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
          update: (context, request, repository) {
            repository!.updateAuthenticationRepository(request: request);
            return repository;
          },
        )
      ],
      child: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(repository: context.read<AuthenticationRepository>()),
        child: const LoginContainer(),
      ),
    );
  }
}

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  var isPassVisible = true;
  late LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Đăng nhập"),
        ),
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: BlocConsumer<LoginBloc, LoginStateBase>(
              listener: (context, state) {
                //print(state.message.toString());
                if (state is LoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Đăng nhập thành công")));
                  Navigator.pushReplacementNamed(
                      context, AppConstant.productRouteName);
                }
                if (state is LoginFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message.toString())));
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: true,
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child:
                                          Image.asset(AppConstant.logoCompany)),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildPhoneTextField(),
                                        _buildPasswordTextField(),
                                        _buildTextRememberForgerPass(),
                                        _buildButtonSignIn(),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: _buildTextSignUp()),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (state is LoginLoading)
                      const Center(child: LoadingWidget())
                  ],
                );
              },
            ),
          ),
        ));
  }

  Widget _buildTextRememberForgerPass() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppConstant.forgetRouteName);
            },
            child: const Text("Quên mật khẩu ?",
                style: TextStyle(
                    color: Colors.teal, decoration: TextDecoration.none)),
          )
        ],
      ),
    );
  }

  Widget _buildTextSignUp() {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Chưa có tài khoản ? "),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppConstant.signupRouteName);
              },
              child: const Text("Đăng ký ngay",
                  style: TextStyle(
                      color: Colors.teal, decoration: TextDecoration.none)),
            )
          ],
        ));
  }

  Widget _buildPhoneTextField() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "Điện thoại",
          labelStyle: const TextStyle(color: Colors.teal),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          prefixIcon: const Icon(Icons.phone, color: Colors.teal),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _passController,
        obscureText: isPassVisible,
        keyboardType: TextInputType.text,
        autofillHints: const [AutofillHints.password],
        onEditingComplete: () => TextInput.finishAutofillContext(),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "Mật khẩu",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 0, color: Colors.black12)),
          labelStyle: const TextStyle(color: Colors.teal),
          prefixIcon: const Icon(Icons.lock, color: Colors.teal),
          suffixIcon: InkWell(
            onTap: () {
              setState(() => isPassVisible = !isPassVisible);
            },
            child: IconButton(
              icon: isPassVisible
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () {
                setState(() => isPassVisible = !isPassVisible);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSignIn() {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: () {
            String phone = _phoneController.text.toString();
            String password = _passController.text.toString();

            _bloc.add(LoginEvent(phone: phone, password: password));
          },
          child: const Text("Đăng nhập"),
        ));
  }
}
