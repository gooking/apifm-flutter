# 功能介绍

apifm 为你提供了 Flutter 的云开发支持，无需服务器，无需开发接口和后台，开箱即用，轻松开发 Flutter

只要你会 Flutter 开发就够了！免费注册开发者后台账号，勾选你需要的模块（CMS、CRM、商城等等），在后台发布并管理你的数据，通过 apifm 扩展直接调用即可

希望你能爱上TA

QQ交流群: 577126347

# 平台支持

* [微信小程序开发](https://github.com/gooking/apifm-wxapi)
* [web/h5 网站开发](https://github.com/gooking/apifm-webapi)
* [Flutter 开发](https://github.com/gooking/apifm-flutter)

# 使用方法

## pubspec.yaml 文件增加依赖
```
dependencies:
  apifm: ^0.0.5
```

## 安装依赖

```bash
$ flutter pub get
```

## 引入 package

```js
import 'package:apifm/apifm.dart' as Apifm;
```

## 初始化

```js
Apifm.init("gooking");
```

*gooking* 为你的开发者后台的专属域名，登录你的开发者后台，在后台首页即可查看属于你的专属域名「默认情况下为32个字母长度的字符串」

[>> 前往免费注册开通开发者后台](https://www.it120.cc/)

## 调用api接口

这里以查询手机号码归属地(queryMobileLocation)的调用后台接口为例子说明如何在 Flutter 中使用 apifm ，其他接口，你可以根据使用文档的说明调用相应的方法即可

### await 方式调用「推荐」：

```js
var res = await Apifm.queryMobileLocation("13500000000");
print(res);
```

### Future 异步方法:

```js
Apifm.queryMobileLocation("13500000000").then((res) {
  print(res);
});
```


# 返回值说明

返回数据 (**res**) 主要包含 3 个内容： 

1. code 错误码，0 代表操作重构，其他数字均表示错误，具体错误描述请查看 msg；
2. msg 如果上面的code不为0，那么 msg 将会返回具体的错误说明描述
3. data 字段保存了 code 为0 时候的数据，一起你需要的数据，都保存在 data 中返回给你

# 相关资源

[「5分钟上手教程」](https://blog.csdn.net/abccba9978/article/category/9329782)
[「Demo程序」](https://github.com/gooking/apifm-flutter-demo)
[「功能说明文档」](https://www.yuque.com/apifm/nu0f75/vkifm4)
[「api接口文档」](https://api.it120.cc/doc.html)

# 授权协议

[MIT License](LICENSE)