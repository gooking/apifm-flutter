import 'package:apifm/apifm.dart' as Apifm;

mockHoldon() async {
  return Future.delayed(Duration(seconds: 60), () => print('防止主进程结束'));
}

main() async{
  // Apifm.request('', false, '', '').then((res) {
  //   print(res);
  // });

  Apifm.init("gooking");
  // Apifm.init2('http://127.0.0.1:8081', "gooking");

  // print(await Apifm.request('/common/region/v2/province', false, 'get'));
  // print(await Apifm.request('/common/region/v2/child', false, 'get', {'pid': '330000000000'}));
  // print(await Apifm.request('/common/mobile-segment/next', false, 'post', {'segment': '0'}));
  // print(await Apifm.request('/score/send/rule', true, 'post'));
  
  // var res = await Apifm.login_username('zansan', '123456', '33010500879931234', 'iphone8 Plus');
  // print(res);
  // int uid = res['data']['uid'];
  // String token = res['data']['token'];
  // print('uid: $uid, token is : $token');

  var res = Apifm.graphValidateCodeUrl();
  print(res);
  print(res['key']);
  print(res['imageUrl']);

  var res2 = await Apifm.graphValidateCodeCheck('0.31748667168061806', '2010');
  print(res2);
  // print(await Apifm.login_username({
  //   'username': 'zansan',
  //   'pwd': '123456',    
  //   'deviceId': '33010500879931234',    
  //   'deviceName': 'iphone8 Plus',    
  // }));


  // await mockHoldon();  // 防止主进程结束
}
