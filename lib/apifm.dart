library apifm;

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

var _API_BASE_URL = 'https://api.it120.cc';
var _SUB_DOMAIN = 'tz';
var _MERCHANT_ID = '0';

// _mockHoldon() async {
//   // 模拟接口等待5秒
//   return Future.delayed(Duration(seconds: 5), () {});
// }

init(b) {
  _SUB_DOMAIN = b;
}

init2(a, b) {
  _API_BASE_URL = a;
  _SUB_DOMAIN = b;
}

setMerchantId(mchid) {
  _MERCHANT_ID = mchid;
}

request(url, needSubDomain, method, [data]) async {
  if (data == null) {
    data = {};
  }
  // await _mockHoldon();
  String _url = _API_BASE_URL + (needSubDomain ? '/' + _SUB_DOMAIN : '') + url;
  if (method.toLowerCase() == 'get') {
    // 拼接参数
    if (data.length > 0) {
      data.forEach((key, value) {
        if (_url.indexOf("?") == -1) {
          _url = _url + "?$key=$value";
        } else {
          _url = _url + "&$key=$value";
        }
      });
    }
    var response = await http.get(_url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    }
    throw Exception('api server response error with statusCode ${response.statusCode}');
  }
  if (method.toLowerCase() == 'post') {
    var response = await http.post(_url, body: data);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    }
    throw Exception('api server response error with statusCode ${response.statusCode}');
  }
  throw Exception('error param method');
}

banners([data]) {
  return request('/banner/list', true, 'get', data);
}
queryMobileLocation(mobile) {
  return request('/common/mobile-segment/location', false, 'get', {
    'mobile': mobile
  });
}
nextMobileSegment(data) {
  return request('/common/mobile-segment/next', false, 'post', data);
}
forexRate(fromCode, toCode) {
  return request('/forex/rate', true, 'get', { fromCode, toCode });
}
queryConfigValue(key) {
  return request('/config/value', true, 'get', {
    'key': key
  });
}
queryConfigBatch(keys) {
  return request('/config/values', true, 'get', {
    'keys': keys
  });
}
scoreRules([data]) {
  return request('/score/send/rule', true, 'post', data);
}
scoreSignRules () {
  return request('/score/sign/rules', true, 'get');
}
scoreSign (token) {
  return request('/score/sign', true, 'post', {
    'token': token
  });
}
scoreSignLogs (data) {
  return request('/score/sign/logs', true, 'post', data);
}
scoreTodaySignedInfo (token) {
  return request('/score/today-signed', true, 'get', {
    'token': token
  });
}
scoreExchange (token, number) {
  return request('/score/exchange', true, 'post', {
    'number': number,
    'token': token
  });
}
scoreLogs (data) {
  return request('/score/logs', true, 'post', data);
}
kanjiaSet (goodsId) {
  return request('/shop/goods/kanjia/set', true, 'get', {
    'goodsId': goodsId
  });
}
kanjiaJoin (token, kjid) {
  return request('/shop/goods/kanjia/join', true, 'post', {
    'kjid': kjid,
    'token': token
  });
}
kanjiaDetail (kjid, joiner) {
  return request('/shop/goods/kanjia/info', true, 'get', {
    'kjid': kjid,
    'joiner': joiner
  });
}
kanjiaHelp (token, kjid, joiner, [remark]) {
  return request('/shop/goods/kanjia/help', true, 'post', {
    'kjid': kjid,
    'joinerUser': joiner,
    'token': token,
    'remark': remark
  });
}
kanjiaClear (token, kjid) {
  return request('/shop/goods/kanjia/clear', true, 'post', {
    'kjid': kjid,
    'token': token
  });
}
kanjiaMyJoinInfo (token, kjid) {
  return request('/shop/goods/kanjia/my', true, 'get', {
    'kjid': kjid,
    'token': token
  });
}
kanjiaHelpDetail (token, kjid, joiner) {
  return request('/shop/goods/kanjia/myHelp', true, 'get', {
    'kjid': kjid,
    'joinerUser': joiner,
    'token': token
  });
}
checkToken (token) {
  return request('/user/check-token', true, 'get', {
    'token': token
  });
}
payVariableUrl (url, data) {
  return request(url, true, 'post', data);
}
wxpay (data) {
  return request('/pay/wx/wxapp', true, 'post', data);
}
wxpayH5(data) {
  return request('/pay/wx/h5', true, 'post', data);
}
wxpayJsapi(data) {
  return request('/pay/wx/jsapi', true, 'post', data);
}
wxpayQrcode(data) {
  return request('/pay/wx/qrcode', true, 'post', data);
}
wxpayFOMO(data) {
  return request('/pay/fomo/wxapp', true, 'post', data);
}
payNow(data) {
  return request('/pay/fomo/payNow', true, 'post', data);
}
fomoCheckout(data) {
  return request('/pay/fomo/checkout', true, 'post', data);
}
wxpayFWS(data) {
  return request('/pay/wxfws/wxapp', true, 'post', data);
}
ttpay(data) {
  return request('/pay/tt/microapp', true, 'post', data);
}
ttEcpay(data) {
  return request('/pay/tt/ecpay', true, 'post', data);
}
payQuery(token, outTradeId) {
  return request('/pay/query', true, 'get', { token, outTradeId });
}
wxpaySaobei(data) {
  return request('/pay/lcsw/wxapp', true, 'post', data);
}
wxpayWepayez(data) {
  return request('/pay/wepayez/wxapp', true, 'post', data);
}
wxpayxpert(data) {
  return request('/pay/payxpert/wxapp', true, 'post', data);
}
wxpayIPaynow(data) {
  return request('/pay/ipaynow/wxapp', true, 'post', data);
}
wxpayAirwallex(data) {
  return request('/pay/airwallex/wxapp', true, 'post', data);
}
paypalCheckout(data) {
  return request('/pay/paypal/checkout', true, 'post', data);
}
alipay (data) {
  return request('/pay/alipay/semiAutomatic/payurl', true, 'post', data);
}
loginUsername (username, pwd, deviceId, deviceName) {
  return request('/user/username/login', true, 'post', {
    'username': username,
    'pwd': pwd,
    'deviceId': deviceId,
    'deviceName': deviceName,
  });
}
loginEmail(email, pwd, deviceId, deviceName) {
  return request('/user/email/login', true, 'post', {
    'email': email,
    'pwd': pwd,
    'deviceId': deviceId,
    'deviceName': deviceName,
  });
}
bindUsername (token, username, [pwd]) {
  return request('/user/username/bindUsername', true, 'post', {
    'token': token,
    'username': username,
    'pwd': pwd
  });
}
loginMobile (mobile, pwd, deviceId, deviceName) {
  return request('/user/m/login', true, 'post', {
    'mobile': mobile,
    'pwd': pwd,
    'deviceId': deviceId,
    'deviceName': deviceName,
  });
}
resetPwdUseMobileCode (mobile, pwd, code) {
  return request('/user/m/reset-pwd', true, 'post', {
    'mobile': mobile,
    'pwd': pwd,
    'code': code
  });
}
resetPwdUseEmailCode (email, pwd, code) {
  return request('/user/email/reset-pwd', true, 'post', {
    'email': email,
    'pwd': pwd,
    'code': code
  });
}
registerUsername (data) {
  return request('/user/username/register', true, 'post', data);
}
registerMobile (data) {
  return request('/user/m/register', true, 'post', data);
}
goodsCategory () {
  return request('/shop/goods/category/all', true, 'get');
}
goods ([data]) {
  return request('/shop/goods/list', true, 'post', data);
}
goodsv2 ([data]) {
  return request('/shop/goods/list/v2', true, 'post', data);
}
goodsDetail (id) {
  return request('/shop/goods/detail', true, 'get', {
    'id': id
  });
}
goodsLimitations(goodsId, [priceId]) {
  return request('/shop/goods/limitation', true, 'get', {
    'goodsId': goodsId,
    'priceId': priceId
  });
}
goodsLimitationsV2(goodsId, [propertyChildIds]) {
  return request('/shop/goods/limitation', true, 'get', {
    goodsId, propertyChildIds
  });
}
goodsPrice(goodsId, propertyChildIds) {
  return request('/shop/goods/price', true, 'post', {
    'goodsId': goodsId,
    'propertyChildIds': propertyChildIds
  });
}
goodsPriceDaily (goodsId, [priceId]) {
  return request('/shop/goods/price/day', true, 'get', {
    'goodsId': goodsId,
    'priceId': priceId
  });
}
goodsPriceFreight (data) {
  return request('/shop/goods/price/freight', true, 'get', data);
}
goodsRebate (token, goodsId) {
  return request('/shop/goods/rebate', true, 'get', {
    'token': token,
    'goodsId': goodsId
  });
}
goodsReputation (data) {
  return request('/shop/goods/reputation', true, 'post', data);
}
goodsFavList (data) {
  return request('/shop/goods/fav/list', true, 'post', data);
}
goodsFavPut (token, goodsId) {
  return request('/shop/goods/fav/add', true, 'post', {
    'token': token,
    'goodsId': goodsId
  });
}
goodsFavCheck (token, goodsId) {
  return request('/shop/goods/fav/check', true, 'get', {
    'token': token,
    'goodsId': goodsId
  });
}
goodsFavCheckV2 (data) {
  return request('/shop/goods/fav/check', true, 'get', data);
}
goodsFavDelete (token, {id, goodsId}) {
  return request('/shop/goods/fav/delete', true, 'post', {
    'token': token,
    'id': id,
    'goodsId': goodsId
  });
}
goodsFavDeleteV2 (data) {
  return request('/shop/goods/fav/delete', true, 'post', data);
}
goodsSeckillGrab (goodsId, seconds) {
  return request('/goods/seckill/grab', false, 'post', {
    'goodsId': goodsId,
    'seconds': seconds
  });
}
coupons (data) {
  return request('/discounts/coupons', true, 'get', data);
}
couponDetail (id) {
  return request('/discounts/detail', true, 'get', {
    'id': id
  });
}
myCoupons (data) {
  return request('/discounts/my', true, 'get', data);
}
fetchCoupons (data) {
  return request('/discounts/fetch', true, 'post', data);
}
sendCoupons (data) {
  return request('/discounts/send', true, 'post', data);
}
exchangeCoupons (token, number, pwd) {
  return request('/discounts/exchange', true, 'post', {
    'token': token,
    'number': number,
    'pwd': pwd
  });
}
noticeList (data) {
  return request('/notice/list', true, 'post', data);
}
noticeLastOne ([type]) {
  return request('/notice/last-one', true, 'get', {
    'type': type
  });
}
noticeDetail (id) {
  return request('/notice/detail', true, 'get', {
    'id': id
  });
}
addAddress (data) {
  return request('/user/shipping-address/add', true, 'post', data);
}
updateAddress (data) {
  return request('/user/shipping-address/update', true, 'post', data);
}
deleteAddress (token, id) {
  return request('/user/shipping-address/delete', true, 'post', {
    'id': id,
    'token': token
  });
}
queryAddress (token) {
  return request('/user/shipping-address/list', true, 'get', {
    'token': token
  });
}
defaultAddress (token) {
  return request('/user/shipping-address/default/v2', true, 'get', {
    'token': token
  });
}
addressDetail (token, id) {
  return request('/user/shipping-address/detail/v2', true, 'get', {
    'id': id,
    'token': token
  });
}
pingtuanSet (goodsId) {
  return request('/shop/goods/pingtuan/set', true, 'get', {
    'goodsId': goodsId
  });
}
pingtuanSets (goodsIds) {
  return request('/shop/goods/pingtuan/sets', true, 'get', {
    'goodsId': goodsIds
  });
}
pingtuanOpen (token, goodsId) {
  return request('/shop/goods/pingtuan/open', true, 'post', {
    'goodsId': goodsId,
    'token': token
  });
}
pingtuanList (data) {
  return request('/shop/goods/pingtuan/list/v2', true, 'post', data);
}
pingtuanJoinUsers (tuanId) {
  return request('/shop/goods/pingtuan/joiner', true, 'get', {
    'tuanId': tuanId
  });
}
pingtuanMyJoined (data) {
  return request('/shop/goods/pingtuan/my-join-list', true, 'post', data);
}
friendlyPartnerList ([type]) {
  return request('/friendly-partner/list', true, 'post', {
    'type': type
  });
}
friendList (data) {
  return request('/user/friend/list', true, 'post', data);
}
addFriend (token, uid) {
  return request('/user/friend/add', true, 'post', {
    'token': token,
    'uid': uid
  });
}
friendUserDetail (token, uid) {
  return request('/user/friend/detail', true, 'get', {
    'token': token,
    'uid': uid
  });
}
videoDetail (videoId) {
  return request('/media/video/detail', true, 'get', {
    'videoId': videoId
  });
}
bindMobileSms (token, mobile, code, [pwd]) {
  return request('/user/m/bind-mobile', true, 'post', {
    'token': token,
    'mobile': mobile,
    'code': code,
    'pwd': pwd
  });
}
userDetail (token) {
  return request('/user/detail', true, 'get', {
    'token': token
  });
}
userAmount (token) {
  return request('/user/amount', true, 'get', {
    'token': token
  });
}
orderCreate (data) {
  return request('/order/create', true, 'post', data);
}
orderList (data) {
  return request('/order/list', true, 'post', data);
}
orderDetail (token, id) {
  return request('/order/detail', true, 'get', {
    'id': id,
    'token': token
  });
}
orderDelivery (token, orderId) {
  return request('/order/delivery', true, 'post', {
    'orderId': orderId,
    'token': token
  });
}
orderReputation (data) {
  return request('/order/reputation', true, 'post', data);
}
orderClose (token, orderId) {
  return request('/order/close', true, 'post', {
    'orderId': orderId,
    'token': token
  });
}
orderDelete (token, orderId) {
  return request('/order/delete', true, 'post', {
    'orderId': orderId,
    'token': token
  });
}
orderPay (token, orderId) {
  return request('/order/pay', true, 'post', {
    'orderId': orderId,
    'token': token
  });
}
orderHX (hxNumber) {
  return request('/order/hx', true, 'post', {
    'hxNumber': hxNumber
  });
}
orderRefunds (token, orderId) {
  return request('/order/refund', true, 'get', {
    'token': token,
    'orderId': orderId
  });
}
withDrawApply (token, money) {
  return request('/user/withDraw/apply', true, 'post', {
    'money': money,
    'token': token
  });
}
withDrawDetail (token, id) {
  return request('/user/withDraw/detail', true, 'get', {
    'token': token,
    'id': id
  });
}
withDrawLogs (data) {
  return request('/user/withDraw/list', true, 'post', data);
}
province () {
  return request('/common/region/v2/province', false, 'get');
}
nextRegion (pid) {
  return request('/common/region/v2/child', false, 'get', {
    'pid': pid
  });
}
cashLogs (data) {
  return request('/user/cashLog', true, 'post', data);
}
payLogs (data) {
  return request('/user/payLogs', true, 'post', data);
}
rechargeSendRules () {
  return request('/user/recharge/send/rule', true, 'get');
}
payBillDiscounts () {
  return request('/payBill/discounts', true, 'get');
}
payBill (token, money) {
  return request('/payBill/pay', true, 'post', {
    'token': token,
    'money': money
  });
}
vipLevel () {
  return request('/config/vipLevel', true, 'get');
}
fxApply(token, name, mobile) {
  return request('/saleDistribution/apply', true, 'post', {
    'token': token,
    'name': name,
    'mobile': mobile
  });
}
fxApplyV2(data) {
  return request('/saleDistribution/apply/v2', true, 'post', data);
}
fxSetting() {
  return request('/saleDistribution/setting', true, 'get');
}
fxBuy(token) {
  return request('/saleDistribution/buy', true, 'post', { token });
}
fxApplyProgress(token) {
  return request('/saleDistribution/apply/progress', true, 'get', {
    'token': token
  });
}
fxApplyProgressV2(token) {
  return request('/saleDistribution/apply/progress/v2', true, 'get', { 'token': token });
}
fxMembers(data) {
  return request('/saleDistribution/members', true, 'post', data);
}
fxCommisionLog(data) {
  return request('/saleDistribution/commision/log', true, 'post', data);
}
fxCommisionFreezeAmount(token) {
  return request('/saleDistribution/commission/freeze', true, 'get', { token });
}
fxSaleroomRankTotal(page, pageSize) {
  return request('/saleDistribution/sale-room-rank/total', true, 'get', {
    page, pageSize
  });
}
fxSaleroomRankDaily(page, pageSize, day) {
  return request('/saleDistribution/sale-room-rank/daily', true, 'get', {
    page, pageSize, day
  });
}
fxMembersStatistics(token) {
  return request('/saleDistribution/members/statistics', true, 'get', { token });
}
fxMyCommisionStatistics(token, days) {
  return request('/saleDistribution/my/commision', true, 'get', { token, days });
}
fxGoods(data) {
  return request('/saleDistribution/goods', true, 'post', data);
}
fxTeamReport(data) {
  return request('/saleDistribution/team/report', true, 'post', data);
}
fxCities(token) {
  return request('/saleDistribution/city/list', true, 'get', { token });
}
fxCityReport(data) {
  return request('/saleDistribution/city/report', true, 'post', data);
}
goodsSellNumberStatistics(page, pageSize, [goodsId]) {
  return request('/site/goods/statistics', true, 'get', {
    page, pageSize, goodsId
  });
}
wxaQrcode(data) {
  return request('/qrcode/wxa/unlimit', true, 'post', data);
}
ttaQrcode(paramsJson, expireHours) {
  return request('/user/tt/microapp/qrcode', true, 'post', {
    'content': convert.jsonEncode(paramsJson),
    'expireHours': expireHours
  });
}
commonQrcode(data) {
  return request('/qrcode/content', true, 'post', data);
}
uploadFile(token, tempFilePath) {
  // TODO
  print('请联系我们完善该功能');
}
uploadFileFromUrl (remoteFileUrl, ext) {
  return request('/dfs/upload/url', true, 'post', {
    'remoteFileUrl': remoteFileUrl,
    'ext': ext
  });
}
uploadFileList ([path]) {
  return request('/dfs/upload/list', true, 'post', {
    'path': path
  });
}
refundApply (data) {
  return request('/order/refundApply/apply', true, 'post', data);
}
refundApplyDetail (token, orderId) {
  return request('/order/refundApply/info', true, 'get', {
    'token': token,
    'orderId': orderId
  });
}
refundApplyCancel (token, orderId) {
  return request('/order/refundApply/cancel', true, 'post', {
    'token': token,
    'orderId': orderId
  });
}
cmsCategories () {
  return request('/cms/category/list', true, 'get', {});
}
cmsCategoryDetail (id) {
  return request('/cms/category/detail', true, 'get', {
    'id': id
  });
}
cmsArticles (data) {
  return request('/cms/news/list', true, 'post', data);
}
cmsArticlesV2 (data) {
  return request('/cms/news/list/v2', true, 'post', data);
}
cmsArticleUsefulLogs (data) {
  return request('/cms/news/useful/logs', true, 'post', data);
}
cmsArticleDetail (id) {
  return request('/cms/news/detail', true, 'get', {
    'id': id
  });
}
cmsArticlePreNext (id) {
  return request('/cms/news/preNext', true, 'get', {
    'id': id
  });
}
cmsArticleCreate (data) {
  return request('/cms/news/put', true, 'post', data);
}
cmsArticleDelete (token, id) {
  return request('/cms/news/del', true, 'post', {
    'token': token,
    'id': id
  });
}
cmsArticleUseless (data) {
  return request('/cms/news/useful', true, 'post', data);
}
cmsPage (key) {
  return request('/cms/page/info', true, 'get', {
    'key': key
  });
}
cmsTags () {
  return request('/cms/tags/list', true, 'get', {});
}
invoiceList (data) {
  return request('/invoice/list', true, 'post', data);
}
invoiceApply (data) {
  return request('/invoice/apply', true, 'post', data);
}
invoiceDetail (token, id) {
  return request('/invoice/info', true, 'get', {
    'token': token,
    'id': id
  });
}
depositList (data) {
  return request('/deposit/list', true, 'post', data);
}
payDeposit (data) {
  return request('/deposit/pay', true, 'post', data);
}
depositInfo (token, id) {
  return request('/deposit/info', true, 'get', {
    'token': token,
    'id': id
  });
}
depositBackApply(token, id) {
  return request('/deposit/back/apply', true, 'post', {
    'token': token,
    'id': id
  });
}
shopAreaCities() {
  return request('/shopArea/cities', true, 'get');
}
shopAreaList(data) {
  return request('/shopArea/list', true, 'post', data);
}
shopAreaDetail(id) {
  return request('/shopArea/detail', true, 'get', { id });
}
fetchShopsCities() {
  return request('/shop/subshop/cities', true, 'get');
}
fetchShops(data) {
  return request('/shop/subshop/list', true, 'post', data);
}
shopSubdetail (id) {
  return request('/shop/subshop/detail/v2', true, 'get', {
    'id': id
  });
}
addComment (data) {
  return request('/comment/add', true, 'post', data);
}
commentList (data) {
  return request('/comment/list', true, 'post', data);
}
modifyUserInfo (data) {
  return request('/user/modify', true, 'post', data);
}
uniqueId ([type]) {
  return request('/uniqueId/get', true, 'get', {
    'type': type
  });
}
queryBarcode (barcode) {
  return request('/barcode/info', true, 'get', {
    'barcode': barcode
  });
}
luckyInfo (id) {
  return request('/luckyInfo/info', true, 'get', {
    'id': id
  });
}
luckyInfoJoin (token, id) {
  return request('/luckyInfo/join', true, 'post', {
    'id': id,
    'token': token
  });
}
luckyInfoJoinMy (token, id) {
  return request('/luckyInfo/join/my', true, 'get', {
    'id': id,
    'token': token
  });
}
luckyInfoJoinLogs (data) {
  return request('/luckyInfo/join/logs', true, 'post', data);
}
jsonList ([data]) {
  return request('/json/list', true, 'post', data);
}
jsonSet (data) {
  return request('/json/set', true, 'post', data);
}
jsonDelete (id, [token]) {
  return request('/json/delete', true, 'post', {
    'token': token,
    'id': id
  });
}
graphValidateCodeUrl () {
  var key = Random().nextDouble().toString();
  var imageUrl = _API_BASE_URL + '/' + _SUB_DOMAIN + '/verification/pic/get?key=' + key;
  return {
    'key': key,
    'imageUrl': imageUrl,
  };
}
graphValidateCodeCheck (key, code) {
  return request('/verification/pic/check', true, 'post', {
    'key': key,
    'code': code
  });
}
shortUrl (url) {
  return request('/common/short-url/shorten', false, 'post', {
    'url': url
  });
}
smsValidateCode (mobile, [key, picCode]) {
  return request('/verification/sms/get', true, 'get', {
    'mobile': mobile,
    'key': key,
    'picCode': picCode
  });
}
smsValidateCodeCheck (mobile, code) {
  return request('/verification/sms/check', true, 'post', {
    'mobile': mobile,
    'code': code
  });
}
mailValidateCode(mail) {
  return request('/verification/mail/get', true, 'get', {
    'mail': mail
  });
}
mailValidateCodeCheck(mail, code) {
  return request('/verification/mail/check', true, 'post', {
    'mail': mail,
    'code': code
  });
}
gpsDistance(data) {
  return request('/common/map/qq/distance', false, 'post', data);
}
mapDistance(lat1, lng1, lat2, lng2) {
  return request('/common/map/distance', false, 'get', {
    'lat1': lat1,
    'lng1': lng1,
    'lat2': lat2,
    'lng2': lng2
  });
}
mapDistanceNavigation(key, mode, from, to) {
  return request('/common/map/qq/distance', false, 'post', { 
    'key': key,
    'mode': mode,
    'from': from,
    'to': to
  });
}
mapQQAddress (location, [coordType = '5']) {
  return request('/common/map/qq/address', false, 'get', {
    'location': location,
    'coord_type': coordType
  });
}
mapQQSearch (data) {
  return request('/common/map/qq/search', false, 'post', data);
}
virtualTraderList (data) {
  return request('/virtualTrader/list', true, 'post', data);
}
virtualTraderDetail (token, id) {
  return request('/virtualTrader/info', true, 'get', {
    'token': token,
    'id': id
  });
}
virtualTraderBuy (token, id) {
  return request('/virtualTrader/buy', true, 'post', {
    'token': token,
    'id': id
  });
}
virtualTraderMyBuyLogs (data) {
  return request('/virtualTrader/buy/logs', true, 'post', data);
}
queuingTypes ([status]) {
  return request('/queuing/types', true, 'get', {
    'status': status
  });
}
queuingGet (token, typeId, [mobile]) {
  return request('/queuing/get', true, 'post', {
    'token': token,
    'typeId': typeId,
    'mobile': mobile
  });
}
queuingMy (token, [typeId, status]) {
  return request('/queuing/my', true, 'get', {
    'token': token,
    'typeId': typeId,
    'status': status
  });
}
idcardCheck (token, name, idCardNo) {
  return request('/user/idcard', true, 'post', {
    'token': token,
    'name': name,
    'idCardNo': idCardNo
  });
}
loginout (token) {
  return request('/user/loginout', true, 'get', {
    'token': token
  });
}
userLevelList (data) {
  return request('/user/level/list', true, 'post', data);
}
userLevelDetail (levelId) {
  return request('/user/level/info', true, 'get', {
    'id': levelId
  });
}
userLevelPrices (levelId) {
  return request('/user/level/prices', true, 'get', {
    'levelId': levelId
  });
}
userLevelBuy (token, priceId, [isAutoRenew = false, remark]) {
  return request('/user/level/buy', true, 'post', {
    'token': token,
    'userLevelPriceId': priceId,
    'isAutoRenew': isAutoRenew,
    'remark': remark
  });
}
userLevelBuyLogs (data) {
  return request('/user/level/buyLogs', true, 'post', data);
}
messageList (data) {
  return request('/user/message/list', true, 'post', data);
}
messageRead (token, id) {
  return request('/user/message/read', true, 'post', {
    'token': token,
    'id': id
  });
}
messageDelete (token, id) {
  return request('/user/message/del', true, 'post', {
    'token': token,
    'id': id
  });
}
scoreDeductionRules () {
  return request('/score/deduction/rules', true, 'get');
}
voteItems (data) {
  return request('/vote/items', true, 'post', data);
}
voteItemDetail (id) {
  return request('/vote/info', true, 'get', {
    'id': id
  });
}
vote (token, voteId, items, [remark]) {
  return request('/vote/vote', true, 'post', {
    'token': token,
    'voteId': voteId,
    'items': items,
    'remark': remark
  });
}
myVote (token, voteId) {
  return request('/vote/vote/info', true, 'get', {
    'token': token,
    'voteId': voteId,
  });
}
voteLogs (data) {
  return request('/vote/vote/list', true, 'post', data);
}
yuyueItems (data) {
  return request('/yuyue/items', true, 'post', data);
}
yuyueItemDetail (id) {
  return request('/yuyue/info', true, 'get', {
    'id': id
  });
}
yuyueJoin (data) {
  return request('/yuyue/join', true, 'post', data);
}
yuyueJoinPay (token, joinId) {
  return request('/yuyue/pay', true, 'post', {
    'token': token,
    'joinId': joinId
  });
}
yuyueJoinUpdate (token, joinId, extJsonStr) {
  return request('/yuyue/join/update', true, 'post', {
    'token': token,
    'joinId': joinId,
    'extJsonStr': extJsonStr
  });
}
yuyueMyJoinInfo (token, joinId) {
  return request('/yuyue/join/info', true, 'post', {
    'token': token,
    'joinId': joinId
  });
}
yuyueMyJoinLogs (data) {
  return request('/yuyue/join/list', true, 'post', data);
}
yuyueTeams (data) {
  return request('/yuyue/info/teams', true, 'post', data);
}
yuyueTeamDetail (teamId) {
  return request('/yuyue/info/team', true, 'get', {
    'teamId': teamId
  });
}
yuyueTeamMembers (data) {
  return request('/yuyue/info/team/members', true, 'post', data);
}
yuyueTeamDeleteMember (token, joinId) {
  return request('/yuyue/info/team/members/del', true, 'post', {
    'token': token,
    'joinId': joinId
  });
}
registerEmail(data) {
  return request('/user/email/register', true, 'post', data);
}
bindEmail(token, email, code, [pwd]) {
  return request('/user/email/bindUsername', true, 'post', {
    'token': token,
    'email': email,
    'code': code,
    'pwd': pwd
  });
}
registerQQConnect(data) {
  return request('/user/qqconnect/register', true, 'post', data);
}
loginQQConnect(oauthConsumerKey, openid, accessToken) {
  return request('/user/qqconnect/login', true, 'post', {
    'oauthConsumerKey': oauthConsumerKey,
    'openid': openid,
    'accessToken': accessToken,
  });
}
bindQQConnectOpenid (token, oauthConsumerKey, openid, accessToken) {
  return request('/user/qqconnect/bindOpenid', true, 'post', {
    'token': token,
    'oauthConsumerKey': oauthConsumerKey,
    'openid': openid,
    'accessToken': accessToken,
  });
}
registerWX(data) {
  return request('/user/wxsns/register', true, 'post', data);
}
loginWX(code) {
  return request('/user/wxsns/login', true, 'post', {
    'code': code,
  });
}
bindWXOpenid (token, code) {
  return request('/user/wxsns/bindOpenid', true, 'post', {
    'token': token,
    'code': code,
  });
}
goodsDynamic (type) {
  return request('/site/goods/dynamic', true, 'get', { type });
}
usersDynamic (type) {
  return request('/site/user/dynamic', true, 'get', { type });
}
fetchSubDomainByWxappAppid (appid) {
  return request('/subdomain/appid/wxapp', false, 'get', { appid });
}
cmsArticleFavPut (token, newsId) {
  return request('/cms/news/fav/add', true, 'post', { token, newsId });
}
cmsArticleFavCheck (token, newsId) {
  return request('/cms/news/fav/check', true, 'get', { token, newsId });
}
cmsArticleFavList (data) {
  return request('/cms/news/fav/list', true, 'post', data);
}
cmsArticleFavDeleteById (token, id) {
  return request('/cms/news/fav/delete', true, 'post', { token, id });
}
cmsArticleFavDeleteByNewsId (token, newsId) {
  return request('/cms/news/fav/delete', true, 'post', { token, newsId });
}
shippingCarInfo (token, type) {
  return request('/shopping-cart/info', true, 'get', {
    token, type
  });
}
shippingCarInfoAddItem (token, goodsId, number, sku, addition, type) {
  return request('/shopping-cart/add', true, 'post', {
    'token': token,
    'goodsId': goodsId,
    'number': number,
    'sku': (sku != null && sku.length > 0) ? convert.jsonEncode(sku) : '',
    'addition': addition != null && addition.length > 0 ? convert.jsonEncode(addition) : '',
    'type': type
  });
}
shippingCarInfoModifyNumber (token, key, number, type) {
  return request('/shopping-cart/modifyNumber', true, 'post', {
    token, key, number, type
  });
}
shippingCarInfoRemoveItem (token, key, type) {
  return request('/shopping-cart/remove', true, 'post', {
    token, key, type
  });
}
shippingCartSelected (token, key, selected, type) {
  return request('/shopping-cart/select', true, 'post', {
    token, key, selected, type
  });
}
shippingCarInfoRemoveAll (token, type) {
  return request('/shopping-cart/empty', true, 'post', {
    token, type
  });
}
growthLogs (data) {
  return request('/growth/logs', true, 'post', data);
}
exchangeScoreToGrowth (token, deductionScore) {
  return request('/growth/exchange', true, 'post', {
    token, deductionScore
  });
}
wxaMpLiveRooms () {
  return request('/wx/live/rooms', true, 'get');
}
wxaMpLiveRoomHisVedios (roomId) {
  return request('/wx/live/his', true, 'get', {
    roomId
  });
}
peisonFeeList () {
  return request('/fee/peisong/list', true, 'get');
}
peisongMembers (data) {
  return request('/peisong/member/list', true, 'post', data);
}
peisongMemberInfo (token) {
  return request('/peisong/member/info', true, 'get', {
    token
  });
}
peisongMemberChangeWorkStatus (token) {
  return request('/peisong/member/change-work-status', true, 'post', {
    token
  });
}
peisongOrdersGrabbing (token) {
  return request('/peisong/order/grabbing', true, 'get', { token });
}
peisongOrders (data) {
  return request('/peisong/order/list', true, 'post', data);
}
peisongOrderGrab (data) {
  return request('/peisong/order/grab', true, 'post', data);
}
peisongOrderDetail (token, id) {
  return request('/peisong/order/detail', true, 'get', { token, id });
}
peisongOrderEstimatedCompletionTime (data) {
  return request('/peisong/order/estimatedCompletionTime', true, 'post', data);
}
peisongStartService (data) {
  return request('/peisong/order/start-service', true, 'post', data);
}
peisongEndService (data) {
  return request('/peisong/order/end-service', true, 'post', data);
}
peisongOrderAllocation (token, id, uid) {
  return request('/peisong/order/allocation', true, 'post', {
    token, id, uid
  });
}
siteStatistics () {
  return request('/site/statistics', true, 'get');
}
orderStatistics (token) {
  return request('/order/statistics', true, 'get', {
    token
  });
}
orderStatisticsv2(data) {
  return request('/order/statistics', true, 'get', data);
}
siteStatisticsSaleroom (data) {
  return request('/site/statistics/saleroom', true, 'get', data);
}
siteStatisticsSaleroomYear (year) {
  return request('/site/statistics/saleroom/year', true, 'get', { year });
}
bonusLog (data) {
  return request('/bonusLog/list', true, 'post', data);
}
mtjAsset (token) {
  return request('/mtj/asset', true, 'get', { token });
}
mtjSetting () {
  return request('/mtj/setting', true, 'get');
}
mtjLogs (data) {
  return request('/mtj/logs', true, 'post', data);
}
mtjStatistics () {
  return request('/site/statistics/mjt', true, 'get');
}
mtjTransfer (data) {
  return request('/mtj/transfer', true, 'post', data);
}
mtjTransferLogs (data) {
  return request('/mtj/transfer/logs', true, 'post', data);
}
wxOpenAuthorization (data) {
  return request('/user/wxsns/authorization', true, 'post', data);
}
userAttentioncheck (token, uid) {
  return request('/user/attention/check', true, 'get', {
    token, uid
  });
}
userAttentionAdd (token, uid) {
  return request('/user/attention/add', true, 'post', {
    token, uid
  });
}
userAttentionRemove (token, uid) {
  return request('/user/attention/remove', true, 'post', {
    token, uid
  });
}
userAttentionMeList (data) {
  return request('/user/attention/attention-me', true, 'post', data);
}
userMyAttentionList (data) {
  return request('/user/attention/my-attention', true, 'post', data);
}
userAttentionDetail (token, uid) {
  return request('/user/attention/detail', true, 'get', {
    token, uid
  });
}
userAttentionStatistics (token) {
  return request('/user/attention/statistics', true, 'get', {
    token
  });
}
cyTableToken (tableId, key) {
  return request('/cyTable/token', true, 'post', {
    'id': tableId,
    'k': key
  });
}
cyTableAddOrder(data) {
  return request('/cyTable/add-order', true, 'post', data);
}
cyTablePayOrder(data) {
  return request('/cyTable/pay-order', true, 'post', data);
}
goodsTimesSchedule (goodsId, propertyChildIds, brandId, categoryId) {
  return request('/shop/goods/times/schedule', true, 'post', { goodsId, propertyChildIds, brandId, categoryId });
}
goodsTimesDays (goodsId, propertyChildIds) {
  return request('/shop/goods/times/days', true, 'post', { goodsId, propertyChildIds });
}
goodsTimesDayItems (day, goodsId, propertyChildIds) {
  return request('/shop/goods/times/items', true, 'post', { day, goodsId, propertyChildIds });
}
goodsBrandList(data) {
  return request('/shop/goods/brand/list', true, 'post', data);
}
goodsBrandDetail(id) {
  return request('/shop/goods/brand/detail', true, 'get', { id });
}
wxappServiceLogin(data) {
  return request('/user/wxappService/login', true, 'post', data);
}
wxappServiceLoginWxaMobile(data) {
  return request('/user/wxappService/login/mobile', true, 'post', data);
}
wxappServiceRegisterComplex(data) {
  return request('/user/wxappService/register/complex', true, 'post', data);
}
wxappServiceRegisterSimple(data) {
  return request('/user/wxappService/register/simple', true, 'post', data);
}
wxappServiceAuthorize(data) {
  return request('/user/wxappService/authorize', true, 'post', data);
}
wxappServiceBindMobile(data) {
  return request('/user/wxappService/bindMobile', true, 'post', data);
}
wxappServiceBindOpenid(data) {
  return request('/user/wxappService/bindOpenid', true, 'post', data);
}
wxappServiceEncryptedData(data) {
  return request('/user/wxappService/decode/encryptedData', true, 'post', data);
}
trtcUserSig(token) {
  return request('/trtc/userSig', true, 'get', { token });
}
setPayPassword (token, pwd) {
  return request('/user/paypwd/set', true, 'post', { token, pwd });
}
modifyPayPassword (token, pwdOld, pwdNew) {
  return request('/user/paypwd/modify', true, 'post', { token, pwdOld, pwdNew });
}
resetPayPassword (mobile, code, pwd) {
  return request('/user/paypwd/reset', true, 'post', { mobile, code, pwd });
}
adPosition(key) {
  return request('/site/adPosition/info', true, 'get', { key });
}
adPositionBatch(keys) {
  return request('/site/adPosition/batch', true, 'get', { keys });
}
goodsVisitLog(data) {
  return request('/goods/visitLog', true, 'post', data);
}
goodsVisitLogAdd(data) {
  return request('/goods/visitLog/add', true, 'post', data);
}
goodsVisitLogDelete(data) {
  return request('/goods/visitLog/delete', true, 'post', data);
}
channelDataPush (key, content) {
  return request('/channelData/push', true, 'post', { key, content });
}
channelDataPull (key) {
  return request('/channelData/pull', true, 'get', { key });
}
bindPartner (token, partnerId) {
  return request('/user/bindPartner', true, 'post', {
    'token': token,
    'uid': partnerId
  });
}
partnerSetting () {
  return request('/partner/setting', true, 'get');
}
partnerBindTeamLeader (token, uid) {
  return request('/partner/bindTeamLeader', true, 'post', { token, uid });
}
partnerBuyTeamLeader(token) {
  return request('/partner/buy', true, 'post', { token });
}
partnerMembersStatistics(token) {
  return request('/partner/members/statistics', true, 'get', { token });
}
partnerMembers(data) {
  return request('/partner/members', true, 'post', data);
}
myLiveRooms(data) {
  return request('/liveRooms/my', true, 'post', data);
}
liveRooms(data) {
  return request('/liveRooms/list', true, 'post', data);
}
myLiveRoomsInfo (token, id) {
  return request('/liveRooms/my/info', true, 'get', { token, id });
}
liveRoomsInfo (token, id) {
  return request('/liveRooms/info', true, 'get', { token, id });
}
liveRoomGoodsMainly(data) {
  return request('/liveRooms/goods/mainly', true, 'post', data);
}
stopLiveRoom (token, id) {
  return request('/liveRooms/my/stop', true, 'post', { token, id });
}
likeLiveRoom (token, id) {
  return request('/liveRooms/like', true, 'post', { token, id });
}
liveRoomOnlineUsers (token, roomId) {
  return request('/websocket/rest/liveRoom/onlines', false, 'get', { token, roomId });
}
liveRoomKickOutUser (token, roomId, uid) {
  return request('/websocket/rest/liveRoom/kickOut', false, 'post', { token, roomId, uid });
}
mockApi (groupName, apiName, method) {
  return request('/mock/'+ groupName +'/' + apiName, true, method);
}
tourJourneyList (type, refId) {
  return request('/tourJourney/list', true, 'get', { type, refId });
}
userBankSelectBanks () {
  return request('/userBank/banks', true, 'get');
}
userBankInfo(token) {
  return request('/userBank/info', true, 'get', { token });
}
userBankBind(data) {
  return request('/userBank/bind', true, 'post', data);
}
userBankUnBind(token) {
  return request('/userBank/unbind', true, 'post', { token });
}
// 京东VOP相关接口
jdvopGoodsList(data) {
  return request('/jdvop/'+ _MERCHANT_ID +'/goods/list', false, 'post', data);
}
jdvopGoodsCheckCanBuy(data) {
  return request('/jdvop/'+ _MERCHANT_ID +'/goods/checkCanBuy', false, 'post', data);
}
jdvopGoodsDetail(goodsId) {
  return request('/jdvop/'+ _MERCHANT_ID +'/goods/detail', false, 'get', {
    'skuId': goodsId,
    'queryExts': 'wxintroduction'
  });
}
jdvopGoodsSkuImages(goodsId) {
  return request('/jdvop/'+ _MERCHANT_ID +'/goods/skuImages', false, 'get', {
    'skuId': goodsId
  });
}
jdvopCartInfo(token) {
  return request('/jdvop/'+ _MERCHANT_ID +'/shopping-cart/info', false, 'get', {
    token
  });
}
jdvopCartAdd(data) {
  return request('/jdvop/'+ _MERCHANT_ID +'/shopping-cart/add', false, 'post', data);
}
jdvopCartModifyNumber (token, key, number) {
  return request('/jdvop/'+ _MERCHANT_ID +'/shopping-cart/modifyNumber', false, 'post', {
    token, key, number
  });
}
jdvopCartSelect (token, key, selected) {
  return request('/jdvop/'+ _MERCHANT_ID +'/shopping-cart/select', false, 'post', {
    token, key, selected
  });
}
jdvopCartRemove (token, key) {
  return request('/jdvop/'+ _MERCHANT_ID +'/shopping-cart/remove', false, 'post', {
    token, key
  });
}
jdvopCartEmpty(token) {
  return request('/jdvop/'+ _MERCHANT_ID +'/shopping-cart/empty', false, 'post', {
    token
  });
}
// 商家从区管进货
jdvopJinhuoGoods(data) {
  return request('/vop/goods/list', true, 'post', data);
}
jdvopJinhuoGoodsDetail (token, skuId) {
  return request('/vop/goods/detail', true, 'get', { token, skuId });
}
// cps
cpsJdGoodsCategory (parentId, grade) {
  return request('/cpsJdGoods/category', true, 'get', { parentId, grade });
}
cpsJdGoodsSearch(data) {
  return request('/cpsJdGoods/search', true, 'post', data);
}
cpsJdGoodsDetail(data) {
  return request('/cpsJdGoods/detail', true, 'get', data);
}
cpsJdGoodsSetExt(data) {
  return request('/cpsJdGoods/ext/set', true, 'post', data);
}
cpsJdGoodsQueryExt(skuId) {
  return request('/cpsJdGoods/ext/query', true, 'get', { skuId });
}
cpsJdGoodsShotUrl (token, skuId) {
  return request('/cpsJdGoods/shotUrl', true, 'get', { token, skuId });
}
cpsJdGoodsShotUrlSite (token, materialUrl, couponUrl) {
  return request('/cpsJdGoods/shotUrl/site', true, 'post', { token, materialUrl, couponUrl });
}
cpsJdOrders(data) {
  return request('/cpsJdOrder/list', true, 'post', data);
}
cpsJdOrderDetail (token, id) {
  return request('/cpsJdOrder/detail', true, 'get', { token, id });
}
cpsPddBeian(token) {
  return request('/cpsPddGoods/beian', true, 'get', { token });
}
cpsPddGoodsDetail(data) {
  return request('/cpsPddGoods/detail', true, 'get', data);
}
cpsPddGoodsShotUrl (token, goodsSign) {
  return request('/cpsPddGoods/shotUrl', true, 'get', { token, goodsSign });
}
cpsPddOrders(data) {
  return request('/cpsPddOrder/list', true, 'post', data);
}
cpsPddOrderDetail (token, id) {
  return request('/cpsPddOrder/detail', true, 'get', { token, id });
}
cpsTaobaoGoodsDetail(data) {
  return request('/cpsTaobaoGoods/detail', true, 'get', data);
}
cpsTaobaoGoodsShotUrl (token, content) {
  return request('/cpsTaobaoGoods/shotUrl', true, 'post', { token, content });
}
cpsTaobaoGoodsKouling (token, content) {
  return request('/cpsTaobaoGoods/kouling', true, 'post', { token, content });
}
// 回收
recycleOrders(data) {
  return request('/recycleOrder/list', true, 'post', data);
}
recycleOrderApply(data) {
  return request('/recycleOrder/apply', true, 'post', data);
}
recycleOrderDetail (token, id) {
  return request('/recycleOrder/detail', true, 'get', { token, id });
}
recycleOrderFahuo(data) {
  return request('/recycleOrder/fahuo', true, 'post', data);
}
recycleOrderClose (token, id) {
  return request('/recycleOrder/close', true, 'post', { token, id });
}
recycleOrderDelete (token, id) {
  return request('/recycleOrder/del', true, 'post', { token, id });
}
// 会员卡
cardList(data) {
  return request('/card/list', true, 'post', data);
}
cardInfo(id) {
  return request('/card/info', true, 'get', { id });
}
cardBuy (token, id) {
  return request('/card/buy', true, 'post', { token, id });
}
cardMyList(token) {
  return request('/card/my', true, 'get', { token });
}
cardMyLogs(data) {
  return request('/card/logs', true, 'post', data);
}
// 收藏卡片
collectCardHis(data) {
  return request('/collectCard/del', true, 'post', data);
}
collectCardInfo (number) {
  return request('/collectCard/cardInfo', true, 'get', { number });
}
collectCardHisInfo (token, id) {
  return request('/collectCard/hisInfo', true, 'get', { token, id });
}
collectCardBind(data) {
  return request('/collectCard/bind', true, 'post', data);
}
collectCardUnBind (token, id, smsCode) {
  return request('/collectCard/bind', true, 'post', { token, id, smsCode });
}
// 其他
bengenSaleTongjiList(data) {
  return request('/bengenSaleTongji/list', true, 'post', data);
}
bengenSaleTongjiRank(data) {
  return request('/bengenSaleTongji/rank', true, 'get', data);
}
// 购买课程
courseInfoList(data) {
  return request('/courseInfo/list', true, 'post', data);
}
courseInfo(id) {
  return request('/courseInfo/info', true, 'get', { id });
}
courseBuyLogPublic(data) {
  return request('/courseBuyLog/public', true, 'post', data);
}
courseBuyLogMy(data) {
  return request('/courseBuyLog/my', true, 'post', data);
}
courseInfoBuy(data) {
  return request('/courseBuyLog/buy', true, 'post', data);
}
courseInfoBuyLogPay (token, orderId) {
  return request('/courseBuyLog/pay', true, 'post', { token, orderId });
}
courseInfoBuyLogDetail (token, id, hxNumber) {
  return request('/courseBuyLog/detail', true, 'get', { token, id, hxNumber });
}
courseInfoBuyLogClose (token, orderId) {
  return request('/courseBuyLog/close', true, 'post', { token, orderId });
}
courseInfoBuyLogDelete (token, orderId) {
  return request('/courseBuyLog/del', true, 'post', { token, orderId });
}
// 橱窗
chuchuanSettingInfo(uid) {
  return request('/chuchuan/info', true, 'get', { uid });
}
chuchuanSettingModify(data) {
  return request('/chuchuan/modify', true, 'post', data);
}
chuchuanGoodsList(data) {
  return request('/chuchuanGoods/list', true, 'post', data);
}
chuchuanGoodsAdd(data) {
  return request('/chuchuanGoods/add', true, 'post', data);
}
chuchuanGoodsRemove (token, goodsId) {
  return request('/chuchuanGoods/remove', true, 'post', { token, goodsId });
}
chuchuanGoodsCheck (token, goodsId) {
  return request('/chuchuanGoods/check', true, 'get', { token, goodsId });
}
// 寄存
jicunGoodsList(data) {
  return request('/jicunGoods/list', true, 'post', data);
}
jicunGoodsDetail(data) {
  return request('/jicunGoods/detail', true, 'get', data);
}
// ocr
ocrBusinessLicense(imageUrl) {
  return request('/ocr/businessLicense', true, 'post', { imageUrl });
}
ocrIdcard(imageUrl) {
  return request('/ocr/idcard', true, 'post', { imageUrl });
}
ocrBankcard(imageUrl) {
  return request('/ocr/bankcard', true, 'post', { imageUrl });
}
ocrDriverLicense(imageUrl) {
  return request('/ocr/driverLicense', true, 'post', { imageUrl });
}
// 朋友圈
momentsPublish(data) {
  return request('/user/moments/publish', true, 'post', data);
}
momentsList(data) {
  return request('/user/moments/list', true, 'get', data);
}
momentsDetail (token, momentsId) {
  return request('/user/moments/detail', true, 'get', { token, momentsId });
}
momentsDelete (token, momentsId) {
  return request('/user/moments/del', true, 'post', { token, momentsId });
}
momentsDeleteComment (token, commentId) {
  return request('/user/moments/delCommon', true, 'post', { token, commentId });
}
momentsLike (token, momentsId) {
  return request('/user/moments/like', true, 'post', { token, momentsId });
}
momentsComment (token, momentsId, uid, content) {
  return request('/user/moments/comment', true, 'post', { token, momentsId, uid, content });
}
momentsCommentLogs(data) {
  return request('/user/moments/logs', true, 'get', data);
}
momentsLogsRead (token, logsIds) {
  return request('/user/moments/logRead', true, 'post', { token, logsIds });
}
bottleMsgPublish(data) {
  return request('/bottleMsg/publish', true, 'post', data);
}
bottleMsgSalvage(token) {
  return request('/bottleMsg/salvage', true, 'get', { token });
}