// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:share_app/main.dart';

import '../model/user.dart';
import '../utils/SpUtils.dart';
import '../widget/beautiful_alert_dialog.dart';

/// 创建时间：2022/9/23
/// 作者：w2gd
/// 描述：login_page

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  var mobile = '';
  var password = '';

  @override
  void initState() {
    super.initState();
    mobileController.text = '17314433312';
    passwordController.text = '123123';
  }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// 用户登录
  Future<void> _login() async {
    var res = await request.post('users/login', data: {"mobile": mobile, "password": password});

    SpUtils.setString('token', res['token']);
    SpUtils.setInt('id', res['id']);

    /// 获取用户信息并存储
    request.get('users/${res['id']}', headers: {'X-Token': res['token']}).then((data) {
      // print(data);
      User user = User.fromJson(data);
      SpUtils.setInt('id', user.id);
      SpUtils.setString('mobile', user.mobile);
      SpUtils.setString('roles', user.roles);
      SpUtils.setString('nickname', user.nickname);
      SpUtils.setString('avatar', user.avatar);
      SpUtils.setInt('bonus', user.bonus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 360,
              foregroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(300),
                ),
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(300), //角度和半径，显示了大圆的一部分作为左上角装饰
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    'http://img.w2gd.top/up/iTab-k762j7.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              // 使用Stack和绝对定位装饰图片和文字
              child: Stack(
                children: [
                  Positioned(
                    top: 70,
                    right: 50,
                    width: 100,
                    height: 150,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'http://img.w2gd.top/up/paper-plane.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.only(top: 60, right: 120),
                      child: Center(
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: Colors.orange.shade300,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    //Email和Password外层容器的装饰效果
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .4),
                            blurRadius: 20,
                            offset: Offset(5, 10),
                          ),
                        ]),
                    child: Column(
                      children: [
                        // 输入框用 Container 包裹，设置边框效果
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: TextField(
                            controller: mobileController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "mobile",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true, // 隐藏输入
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        mobile = mobileController.text;
                        password = passwordController.text;
                      });
                      _login().then((_) {
                        Navigator.pushNamed(context, 'index');
                      }).catchError((e) {
                        showDialog(
                          context: context,
                          builder: (_) => BeautifulAlertDialog(
                            title: '错误！',
                            tip: '请输入正确的账号与密码',
                            tapOk: () {
                              setState(() {
                                passwordController.text = '';
                              });
                            },
                          ),
                        );
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: const [
                            Color.fromRGBO(54, 103, 154, 1),
                            Color.fromRGBO(54, 103, 154, .4),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text("Forgot Password ?", style: TextStyle(color: Colors.indigo.shade200)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
