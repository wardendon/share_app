import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
                            controller: controller.mobileController,
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
                            controller: controller.passwordController,
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
                    onTap: () => controller.login(context),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(54, 103, 154, 1),
                            Color.fromRGBO(54, 103, 154, .4),
                          ],
                        ),
                      ),
                      child: const Center(
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
