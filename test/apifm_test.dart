import 'package:apifm/apifm.dart' as Apifm;

mockHoldon() async {
  return Future.delayed(Duration(seconds: 60), () => print('防止主进程结束'));
}

main() async{
    print("start");

  // Apifm.request('', false, '', '').then((res) {
  //   print(res);
  // });

  Apifm.init("gooking");
  // Apifm.init2('http://127.0.0.1:8081', "gooking");

  // print(await Apifm.request('/common/region/v2/province', false, 'get'));
  // print(await Apifm.request('/common/region/v2/child', false, 'get', {'pid': '330000000000'}));
  // print(await Apifm.request('/common/mobile-segment/next', false, 'post', {'segment': '0'}));
  // print(await Apifm.request('/score/send/rule', true, 'post'));
  
  print(await Apifm.queryMobileLocation("13500000000"));


  // await mockHoldon();  // 防止主进程结束
}
