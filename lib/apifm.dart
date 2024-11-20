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
    // https://pub.dev/packages/http
    var response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    }
    throw Exception('api server response error with statusCode ${response.statusCode}');
  }
  if (method.toLowerCase() == 'post') {
    // https://pub.dev/packages/http
    var response = await http.post(Uri.parse(_url), body: data);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    }
    throw Exception('api server response error with statusCode ${response.statusCode}');
  }
  throw Exception('error param method');
}
bannerTypes() {
    return request('/banner/types', true, 'get');
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
scoreLogs(data) {
  return request('/score/logs', true, 'post', data);
}
scoreDynamics() {
  return request('/score/dynamics', true, 'get');
},
scoreDeductionRules() {
  return request('/score/deduction/rules', true, 'get');
}
scoreDailyFixedNum(token) {
  return request('/score/dailyFixedNum', true, 'post', { token });
}
scoreRank(data) {
  return request('/score/rank', true, 'get', data);
}
scoreRankBydate(data) {
  return request('/score/rankBydate', true, 'get', data);
}
scoreMyStatistics(data) {
  return request('/score/myStatistics', true, 'get', data);
}
scoreTaskList(token) {
  return request('/score/taskList', true, 'get', { token });
}
scoreTaskSuccess(token, type) {
  return request('/score/taskSuccess', true, 'post', { token, type });
}
kanjiaSet(goodsId) {
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
wxpayCode(data) {
  return request('/pay/wx/paymentCode', true, 'post', data);
}
wxpayApp(data) {
  return request('/pay/wx/app', true, 'post', data);
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
ccvvPayWxapp(data) {
  return request('/pay/ccvv/wxapp', true, 'post', data);
}
wxpayAirwallex(data) {
  return request('/pay/airwallex/wxapp', true, 'post', data);
}
paypalCheckout(data) {
  return request('/pay/paypal/checkout', true, 'post', data);
}
alipay(data) {
  return request('/pay/alipay/semiAutomatic/payurl', true, 'post', data);
}
alipayMP(data) {
  return request('/pay/alipay/gate/mp', true, 'post', data);
}
alipayAPP(data) {
  return request('/pay/alipay/gate/app', true, 'post', data);
}
alipayQrcode(data) {
  return request('/pay/alipay/gate/qrcode', true, 'post', data);
}
alipayQrcode2(data) {
  return request('/pay/alipay/gate/paymentCode', true, 'post', data);
}
alipayH5(data) {
  return request('/pay/alipay/gate/h5', true, 'post', data);
}
alipayPC(data) {
  return request('/pay/alipay/gate/pc', true, 'post', data);
}
kasipayH5(data) {
  return request('/pay/kasipay/h5', true, 'post', data);
}
hmpayJsapi(data) {
  return request('/pay/sandpay/hmpay/jsapi', true, 'post', data);
}
login_wx(code) {
  return request('/user/wxapp/login', true, 'post', {
    'code': code,
    'type': 2
  });
}
login_tt(code) {
  return request('/user/tt/microapp/login', true, 'post', {
    'code': code
  });
}
login_q(code) {
  return request('/user/q/login', true, 'post', {
    'code': code,
    'type': 2
  });
}
loginWxaMobileV2(data) {
  return request('/user/wxapp/login/mobile', true, 'post', data);
}
fetchWxaMobile(code) {
  return request('/user/wxapp/getMobile', true, 'get', { code });
}
loginUsername(username, pwd, deviceId, deviceName) {
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
resetPwdUseEmailCode(email, pwd, code) {
  return request('/user/email/reset-pwd', true, 'post', {
    'email': email,
    'pwd': pwd,
    'code': code
  });
}
wxmpAuth(data) {
  return request('/user/wxmp/auth', true, 'post', data);
}
registerUsername(data) {
  return request('/user/username/register', true, 'post', data);
}
registerMobile(data) {
  return request('/user/m/register', true, 'post', data);
}
goodsCategory() {
  return request('/shop/goods/category/all', true, 'get');
}
goodsCategoryV2([shopId]) {
  return request('/shop/goods/category/all', true, 'get', { shopId });
}
goodsCategoryDetail(id) {
  return request('/shop/goods/category/info', true, 'get', { id });
}
goods([data]) {
  return request('/shop/goods/list', true, 'post', data);
}
goodsv2 ([data]) {
  return request('/shop/goods/list/v2', true, 'post', data);
}
goodsDetail(id, [token]) {
  return request('/shop/goods/detail', true, 'get', {
    'id': id,
    'token': token
  });
}
goodsDetailV2(data) {
    return request('/shop/goods/detail', true, 'get', data);
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
goodsAddition(goodsId) {
  return request('/shop/goods/goodsAddition', true, 'get', {
    goodsId
  });
}
goodsVideoEpisodesList(goodsId, [token]) {
  return request('/goodsVideoEpisodes/list', true, 'get', {
    goodsId, token
  });
}
goodsVideoEpisodesBuy(goodsId, number, token) {
  return request('/goodsVideoEpisodes/buy', true, 'post', {
    goodsId, number, token
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
goodsFavList(data) {
  return request('/shop/goods/fav/list', true, 'post', data);
}
goodsFavListV2(data) {
  return request('/shop/goods/fav/list/v2', true, 'post', data);
}
goodsFavPut(token, goodsId) {
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
goodsFavDeleteV2(data) {
  return request('/shop/goods/fav/delete', true, 'post', data);
}
goodsSeckillGrab(token, goodsId, seconds) {
  return request('/goods/seckill/grab', true, 'post', {
    'token': token,
    'goodsId': goodsId,
    'seconds': seconds
  });
}
coupons(data) {
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
exchangeCoupons(token, number, pwd) {
  return request('/discounts/exchange', true, 'post', {
    'token': token,
    'number': number,
    'pwd': pwd
  });
}
couponsShareOpen(token, id) {
  return request('/discounts/share/open', true, 'post', { token, id });
}
couponsShareClose(token, id) {
  return request('/discounts/share/close', true, 'post', { token, id });
}
couponsShareFetch(token, id, shareToken) {
  return request('/discounts/share/fetch', true, 'post', { token, id, shareToken });
}
couponsHX(data) {
  return request('/discounts/hx', true, 'post', data);
}
noticeList(data) {
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
pingtuanSets(goodsIds) {
  return request('/shop/goods/pingtuan/sets', true, 'get', {
    'goodsId': goodsIds
  });
}
pingtuanOpen(token, goodsId, [extJsonStr]) {
  return request('/shop/goods/pingtuan/open', true, 'post', {
    'goodsId': goodsId,
    'token': token,
    'extJsonStr': extJsonStr
  });
}
pingtuanTuanInfo(tuanId) {
  return request('/shop/goods/pingtuan/tuanInfo', true, 'get', {
    tuanId
  });
}
pingtuanList(data) {
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
userDetail(token) {
  return request('/user/detail', true, 'get', {
    'token': token
  });
}
randomNick([len]) {
  return request('/user/randomNick', true, 'get', {
    'len': len
  });
}
userDetailSpreadUser(token, uid) {
  return request('/user/detail/spreadUser', true, 'get', {
    token, uid
  });
}
userWxinfo(token) {
  return request('/user/wxinfo', true, 'get', {
    token
  });
}
userAliappInfo(token) {
  return request('/user/aliappInfo', true, 'get', {
    token
  });
}
userAmount(token) {
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
orderReputation(data) {
  return request('/order/reputation', true, 'post', data);
}
orderReputationList(data) {
  return request('/order/listReputation', true, 'post', data);
}
orderReputationDelete(data) {
  return request('/order/reputation/delete', true, 'post', data);
}
orderReputationModify(data) {
  return request('/order/reputation/modify', true, 'post', data);
}
orderClose(token, orderId) {
  return request('/order/close', true, 'post', {
    'orderId': orderId,
    'token': token
  });
}
orderCloseV2(data) {
  return request('/order/close', true, 'post', data);
}
orderDelete (token, orderId) {
  return request('/order/delete', true, 'post', {
    'orderId': orderId,
    'token': token
  });
}
orderPay(token, orderId) {
  return request('/order/pay', true, 'post', {
    'orderId': orderId,
    'token': token
  });
}
orderPayV2(data) {
  return request('/order/pay', true, 'post', data);
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
withDrawLogs(data) {
  return request('/user/withDraw/list', true, 'post', data);
}
withDrawSetting() {
  return request('/user/withDraw/setting', true, 'get');
}
province() {
  return request('/common/region/v2/province', false, 'get');
}
nextRegion(pid) {
  return request('/common/region/v2/child', false, 'get', {
    'pid': pid
  });
}
regionInfo(id) {
  return request('/common/region/v2/info', false, 'get', {
    id
  });
}
regionInfoBatch(ids) {
  return request('/common/region/v2/infoBatch', false, 'get', {
    ids
  });
}
regionSearch(data) {
  return request('/common/region/v2/search', false, 'post', data);
}
provinceV2() {
  return request('https://common.apifm.com/' + subDomain + '/region/province', false, 'get');
}
cityV2() {
  return request('https://common.apifm.com/' + subDomain + '/region/city', false, 'get');
}
districtsV2(data) {
  return request('https://common.apifm.com/' + subDomain + '/region/districts', false, 'post', data);
}
streetsV2(data) {
  return request('https://common.apifm.com/' + subDomain + '/region/streets', false, 'post', data);
}
nextRegionV2(pid) {
  return request('https://common.apifm.com/' + subDomain + '/region/child', false, 'get', { pid });
}
regionInfoV2(id) {
  return request('https://common.apifm.com/' + subDomain + '/region/info', false, 'get', { id });
}
regionInfoBatchV2(ids) {
  return request('https://common.apifm.com/' + subDomain + '/region/infoBatch', false, 'get', { ids });
}
regionSearchV2(data) {
  return request('https://common.apifm.com/' + subDomain + '/region/search', false, 'post', data);
}
cashLogs(data) {
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
fxSaleroomRankTotalTeam(page, pageSize) {
  return request('/saleDistribution/sale-room-rank/team/total', true, 'get', {
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
  return request('https://oss.apifm.com/' + subDomain + '/qrcode/wxa/unlimit', true, 'post', data);
}
ttaQrcode(paramsJson, expireHours) {
  return request('/user/tt/microapp/qrcode', true, 'post', {
    'content': convert.jsonEncode(paramsJson),
    'expireHours': expireHours
  });
}
commonQrcode(data) {
  return request('https://oss.apifm.com/' + subDomain + '/qrcode/content', true, 'post', data);
}
uploadFile(token, tempFilePath) {
  // TODO
  print('请联系我们完善该功能');
}
uploadFileFromUrl(remoteFileUrl, ext) {
  return request('/dfs/upload/url', true, 'post', {
    'remoteFileUrl': remoteFileUrl,
    'ext': ext
  });
}
uploadFileFromUrlV2(data) {
  return request('https://oss.apifm.com/uploadByUrl', false, 'post', { ...data, subDomain });
}
uploadFileList([path]) {
  return request('/dfs/upload/list', true, 'post', {
    'path': path
  });
}
uploadFileListV2(data) {
  return request('/dfs/upload/list/v2', true, 'post', data);
}
galleryList(data) {
  return request('/dfs/gallery', true, 'post', data);
}
refundApply(data) {
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
cmsArticlesV3(data) {
  return request('https://cms.apifm.com/' + merchantId + '/cms/news/list/v2', true, 'post', data);
}
cmsArticleUsefulLogs (data) {
  return request('/cms/news/useful/logs', true, 'post', data);
}
cmsArticleDetail(id) {
  return request('/cms/news/detail', true, 'get', {
    'id': id
  });
}
cmsArticleDetailV2(id, [token]) {
  return request('/cms/news/detail/v2', true, 'get', { id, token });
}
cmsArticleDetailV3(data) {
  return request('https://cms.apifm.com/' + merchantId + '/cms/news/detail/v2', true, 'get', data);
}
cmsArticlePreNext(id) {
  return request('/cms/news/preNext', true, 'get', {
    'id': id
  });
}
cmsArticlePreNextV2(id) {
  return request('https://cms.apifm.com/' + merchantId + '/cms/news/preNext', true, 'get', { id });
}
cmsArticleCreate(data) {
  return request('/cms/news/put', true, 'post', data);
}
cmsArticleCreateV2(data) {
  return request('https://cms.apifm.com/' + merchantId + '/cms/news/put', true, 'post', data);
}
cmsArticleDelete (token, id) {
  return request('/cms/news/del', true, 'post', {
    'token': token,
    'id': id
  });
}
cmsArticleDeleteV2(token, id) {
  return request('https://cms.apifm.com/' + merchantId + '/cms/news/del', true, 'post', { token, id });
}
cmsArticleUseless(data) {
  return request('/cms/news/useful', true, 'post', data);
}
cmsArticleModifyExtNumber(data) {
  return request('/cms/news/modifyExtNumber', true, 'post', data);
}
cmsArticleModifyExtNumberV2(data) {
  return request('https://cms.apifm.com/' + merchantId + '/cms/news/modifyExtNumber', true, 'post', data);
}
newsOwnerUserViewStatistics(data) {
  return request('/newsOwnerUserViewStatistics/list', true, 'post', data);
}
cmsPage(key) {
  return request('/cms/page/info', true, 'get', {
    'key': key
  });
}
cmsTags() {
  return request('/cms/tags/list', true, 'get', {});
}
cmsTagsV2(data) {
  return request('https://cms.apifm.com/' + merchantId + '/newsTag/list', true, 'post', data);
}
cmsNewsSignUsers(data) {
  return request('/newsSign/signUsers', true, 'post', data);
}
cmsNewsSignOnline(data) {
  return request('/newsSign/signOnline', true, 'post', data);
}
cmsNewsSignOffline(data) {
  return request('/newsSign/signOffline', true, 'post', data);
}
cmsNewsSignCheck(token, newsId) {
  return request('/newsSign/check', true, 'get', { token, newsId });
}
invoiceList(data) {
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
shopSubdetail(id) {
  return request('/shop/subshop/detail/v2', true, 'get', {
    'id': id
  });
}
shopSubApply(data) {
  return request('/shop/subshop/apply', true, 'post', data);
}
pickPoints(data) {
  return request('/shop/subshop/pickPoints', true, 'post', data);
}
shopReputationList(data) {
  return request('/shop/subshop/listReputation', true, 'post', data);
}
shopPicList(data) {
  return request('/shop/subshop/shopPics', true, 'post', data);
}
shopFavPut(token, shopId) {
  return request('/shop/fav/add', true, 'post', { token, shopId });
}
shopFavCheck(token, shopId) {
  return request('/shop/fav/check', true, 'get', { token, shopId });
}
shopFavList(data) {
  return request('/shop/fav/list', true, 'post', data);
}
shopFavDelete(token, shopId) {
  return request('/shop/fav/delete', true, 'post', { token, shopId });
}
userAttendantFavPut(token, attendantId) {
  return request('/userAttendantFav/add', true, 'post', { token, attendantId });
}
userAttendantFavCheck(token, attendantId) {
  return request('/userAttendantFav/check', true, 'get', { token, attendantId });
}
userAttendantFavList(data) {
  return request('/userAttendantFav/list', true, 'post', data);
}
userAttendantFavDelete(token, attendantId) {
  return request('/userAttendantFav/delete', true, 'post', { token, attendantId });
}
addComment(data) {
  return request('/comment/add', true, 'post', data);
}
commentList(data) {
  return request('/comment/list', true, 'post', data);
}
commentListV2(data) {
  return request('/comment/list/v2', true, 'post', data);
}
delComment(data) {
  return request('/comment/del', true, 'post', data);
}
modifyUserInfo(data) {
  return request('/user/modify', true, 'post', data);
}
bindSaleman(data) {
    return request('/user/bindSaleman', true, 'post', data);
  }
  modifyUserPassword(token, pwdOld, pwdNew) {
    return request('/user/modify/password', true, 'post', { token, pwdOld, pwdNew });
  }
  modifyUserPasswordByUserName(data) {
    return request('/user/username/modifyPassword', true, 'post', data);
  }
  anonymousUserInfo(id) {
    return request('/user/anonymous/info', true, 'get', { 'id': id });
  }
uniqueId([type]) {
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
shortUrl(url) {
  return request('/common/short-url/shorten', false, 'post', {
    'url': url
  });
}
shortUrlV2(content) {
    return request('/common/short-url/shorten/v2', false, 'post', { content });
  }
  shortUrlExpand(suffix) {
    return request('/common/short-url/expand', false, 'post', { suffix });
  }
smsValidateCode(mobile, [key, picCode]) {
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
commonIP([ip]) {
    return request('/common/ip', false, 'get', { ip });
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
mapQQAddress(location, [coordType = '5']) {
  return request('/common/map/qq/address', false, 'get', {
    'location': location,
    'coord_type': coordType
  });
}
mapQQAddressV2(key, location, [coord_type = '5']) {
  return request('/common/map/qq/address', false, 'get', { key, location, coord_type });
}
mapQQSearch(data) {
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
idcardCheckManualReview(data) {
  return request('/user/idcard/manualReview', true, 'post', data);
}
idcardCheckManualReviewInfo(token) {
  return request('/user/idcard/manualReview/info', true, 'get', { 'token': token });
}
loginout(token) {
  return request('/user/loginout', true, 'get', {
    'token': token
  });
}
userLogedList(token) {
  return request('/user/logedUserList', true, 'get', { 'token': token });
}
userDelete(token) {
  return request('/user/delete', true, 'post', {
    'token': token
  });
}
dynamicUserCode(token) {
  return request('/user/dynamicUserCode', true, 'get', { 'token': token });
}
userLevelList(data) {
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
voteItems (data) {
  return request('/vote/items', true, 'post', data);
}
voteItemDetail (id) {
  return request('/vote/info', true, 'get', {
    'id': id
  });
}
vote(token, voteId, items, [remark]) {
  return request('/vote/vote', true, 'post', {
    'token': token,
    'voteId': voteId,
    'items': items,
    'remark': remark
  });
}
voteCategory(data) {
  return request('/vote/vote/category', true, 'post', data);
}
myVote(token, voteId) {
  return request('/vote/vote/info', true, 'get', {
    'token': token,
    'voteId': voteId,
  });
}
voteLogs(data) {
  return request('/vote/vote/list', true, 'post', data);
}
voteGroups(data) {
  return request('/vote/vote/groups', true, 'post', data);
}
voteGroupsDetail(data) {
  return request('/vote/vote/groups/detail', true, 'get', data);
}
myInviteVoteJoinList(data) {
  return request('/vote/myInviteLoinList', true, 'post', data);
}
yuyueItems(data) {
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
yuyueJoinUpdate(token, joinId, extJsonStr) {
  return request('/yuyue/join/update', true, 'post', {
    'token': token,
    'joinId': joinId,
    'extJsonStr': extJsonStr
  });
}
yuyueLike(data) {
  return request('/yuyue/like', true, 'post', data);
}
yuyueJoinDelete(token, joinId) {
  return request('/yuyue/delJoin', true, 'post', {
    'token': token,
    'id': joinId
  });
}
yuyueServered(data) {
  return request('/yuyue/servered', true, 'post', data);
}
yuyueMyJoinInfo(token, joinId) {
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
yuyueTeamDeleteMember data {
  return request('/yuyue/info/team/members/del', true, 'post', data);
}
registerEmail(data) {
  return request('/user/email/register', true, 'post', data);
}
bindEmail(token, email, code, [pwd]) {
  return request('/user/email/bindEmail', true, 'post', {
    'token': token,
    'email': email,
    'code': code,
    'pwd': pwd
  });
}
registerQQConnect(data) {
  return request('/user/qqconnect/register', true, 'post', data);
}
qqAuthorize(data) {
  return request('/user/q/authorize', true, 'post', data);
}
qqQrcode(content){
  return request('/user/q/qrcode', true, 'post', { content });
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
bindWXOpenid(token, code) {
  return request('/user/wxsns/bindOpenid', true, 'post', {
    'token': token,
    'code': code,
  });
}
goodsDynamic(type) {
  return request('/site/goods/dynamic', true, 'get', { type });
}
goodsDynamicV2(data) {
  return request('/site/goods/dynamic', true, 'get', data);
}
usersDynamic(type) {
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
shippingCarInfoAddItem(token, goodsId, number, sku, addition, type) {
  return request('/shopping-cart/add', true, 'post', {
    'token': token,
    'goodsId': goodsId,
    'number': number,
    'sku': (sku != null && sku.length > 0) ? convert.jsonEncode(sku) : '',
    'addition': addition != null && addition.length > 0 ? convert.jsonEncode(addition) : '',
    'type': type
  });
}
shippingCarInfoAddItemV2(data) {
    return request('/shopping-cart/add', true, 'post', data);
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
peisongEndService(data) {
  return request('/peisong/order/end-service', true, 'post', data);
}
peisongEndServiceRemark(token, id, remarkEnd) {
  return request('/peisong/order/end-service/remarkEnd', true, 'post', { token, id, remarkEnd });
}
peisongOrderAllocation(token, id, uid) {
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
wxOpenAuthorization(data) {
  return request('/user/wxsns/authorization', true, 'post', data);
}
wxOpenRegister(data) {
    return request('/user/wxsns/register', true, 'post', data);
  }
  wxOpenBindOpenid(data) {
    return request('/user/wxsns/bindOpenid/v2', true, 'post', data);
  }
  wxOpenLogin(data) {
    return request('/user/wxsns/login', true, 'post', data);
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
cyTableInfo(id) {
  return request('/cyTable/info', true, 'get', { id });
}
cyTableList(data) {
  return request('/cyTable/list', true, 'post', data);
}
goodsTimesSchedule(goodsId, propertyChildIds, brandId, categoryId) {
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
wxappServiceBindMobileV2(data) {
  return request('/user/wxappService/bindMobile/v2', true, 'post', data);
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
goodsVisitLogClear(token) {
  return request('/goods/visitLog/clear', true, 'post', { token });
}
channelDataPush(key, content) {
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
cpsJdGoodsCategory(parentId, grade) {
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
  return request('/card/list', true, 'get', data);
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
cardExchangeFromPwd(data) {
    return request('/card/exchange', true, 'post', data);
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
// stripe
stripeAddCard(data) {
  return request('/pay/stripe/addCard', true, 'post', data);
}
stripeCardList(token) {
  return request('/pay/stripe/cardList', true, 'get', { token });
}
stripeDelCard(token, cardId) {
  return request('/pay/stripe/deleteCard', true, 'post', { token, cardId });
}
stripeCharge(data) {
  return request('/pay/stripe/charge', true, 'post', data);
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
momentsLogsRead(token, logsIds) {
  return request('/user/moments/logRead', true, 'post', { token, logsIds });
}
bottleMsgPublish(data) {
  return request('/bottleMsg/publish', true, 'post', data);
}
bottleMsgSalvage(token) {
  return request('/bottleMsg/salvage', true, 'get', { token });
}
userInvoiceInfo(token) {
  return request('/userInvoice/info', true, 'get', { token });
}
userInvoiceUnbind(token) {
  return request('/userInvoice/unbind', true, 'post', { token });
}
userInvoiceBind(data) {
  return request('/userInvoice/bind', true, 'post', data);
}
tempDataSet(key, content) {
  return request('/tempData/set', true, 'post', { key, content });
}
tempDataGet(key) {
  return request('/tempData/get', true, 'get', { key });
}
tempDataSetV2(key, content) {
  return request('https://common.apifm.com/' + merchantId + '/tempData/set', true, 'post', { key, content });
}
tempDataGetV2(key) {
  return request('https://common.apifm.com/' + merchantId + '/tempData/get', true, 'get', { key });
}
commonDatetime() {
  return request('/common/datetime', true, 'get');
}
commonDays(startDay, days) {
  return request('/common/days', false, 'get', { startDay, days });
}
commonDiffMillis(d1, d2) {
  return request('/common/diffMillis', false, 'get', { d1, d2 });
}
// 企业应用 组织/成员/网盘
organizePrices() {
  return request('/organizeInfo/prices', true, 'get');
}
organizeCreate(data) {
  return request('/organizeInfo/create', true, 'post', data);
}
organizeUpgrade(data) {
  return request('/organizeInfo/upgrade', true, 'post', data);
}
organizeModify(data) {
  return request('/organizeInfo/modify', true, 'post', data);
}
organizeJoinKey(data) {
  return request('/organizeInfo/joinKey', true, 'get', data);
}
organizeJoin(data) {
  return request('/organizeInfo/join', true, 'post', data);
}
organizeGrantAdmin(data) {
  return request('/organizeInfo/grantAdmin', true, 'post', data);
}
organizeKick(data) {
  return request('/organizeInfo/kick', true, 'post', data);
}
organizeKickAllMembers(data) {
  return request('/organizeInfo/kickAllMembers', true, 'post', data);
}
organizeKickSelf(data) {
  return request('/organizeInfo/kickSelf', true, 'post', data);
}
organizeNick(data) {
  return request('/organizeInfo/nick', true, 'post', data);
}
organizeDelete(data) {
  return request('/organizeInfo/deleteOrganize', true, 'post', data);
}
organizeMyOrganizeInfo(data) {
  return request('/organizeInfo/myOrganizeInfo', true, 'post', data);
}
organizeDetail(data) {
  return request('/organizeInfo/organizeDetail', true, 'get', data);
}
organizeMembers(data) {
  return request('/organizeInfo/members', true, 'post', data);
}
organizeNoticeList(data) {
  return request('/organizeNotice/list', true, 'post', data);
}
organizeNoticeDetail(data) {
  return request('/organizeNotice/detail', true, 'get', data);
}
organizeNoticeSave(data) {
  return request('/organizeNotice/save', true, 'post', data);
}
organizeNoticeDelete(data) {
  return request('/organizeNotice/del', true, 'post', data);
}
organizePanUpload(data) {
  return request('/organizePan/upload', true, 'post', data);
}
organizePanDownload(data) {
  return request('/organizePan/download', true, 'get', data);
}
organizePanFiles(data) {
  return request('/organizePan/files', true, 'post', data);
}
organizePanModify(data) {
  return request('/organizePan/modify', true, 'post', data);
}
organizePanDelete(data) {
  return request('/organizePan/del', true, 'post', data);
}
newsExtFieldList(token, organizeId, newsId) {
  return request('/newsExtField/extFields', true, 'get', { token, organizeId, newsId });
}
newsExtFieldDynamic(token, newsId) {
  return request('/newsExtField/dynamic', true, 'get', { token, newsId });
}
newsExtFieldSet(data) {
  return request('/newsExtField/setField', true, 'post', data);
}
// 支付宝小程序
aliappUserRegister(data) {
  return request('/user/aliapp/register', true, 'post', data);
}
aliappUserLogin(data) {
  return request('/user/aliapp/login', true, 'post', data);
}
aliappUserAuthorize(data) {
  return request('/user/aliapp/authorize', true, 'post', data);
}
aliappWebUserAuthorize(data) {
  return request('/user/aliappweb/authorize', true, 'post', data);
}
aliappQrcode(content) {
  return request('/user/aliapp/qrcode', true, 'post', { content });
}
userAttendantList(data) {
  return request('/user/attendant/list', true, 'post', data);
}
userAttendantDetail(id, [token]) {
  return request('/user/attendant/detail', true, 'get', { id, token });
}
userAttendantGoods(id) {
  return request('/user/attendant/goods', true, 'get', { id });
}
userAttendantGoodsSet(token, ids) {
  return request('/user/attendant/goodsSet', true, 'post', { token, ids });
}
userAttendantBindShop(token, shopId) {
  return request('/user/attendant/bindShop', true, 'post', { shopId, token });
}
userAttendantUnBindShop(token) {
  return request('/user/attendant/unbindShop', true, 'post', { token });
}
userAttendantChangeStatus(data) {
  return request('/user/attendant/changeStatus', true, 'post', data);
}
userAttendantDaysTimesAttendant(goodsId, day) {
  return request('/user/attendant/daysTimesAttendant', true, 'get', { goodsId, day });
}
userAttendantDaysTimesAttendantSetQuery(token, day) {
  return request('/user/attendant/daysTimesAttendant/set/query', true, 'get', { token, day });
}
userAttendantDaysTimesAttendantSet(data) {
  return request('/user/attendant/daysTimesAttendant/set', true, 'post', data);
}
userAttendantListReputation(data) {
  return request('/user/attendant/listReputation', true, 'post', data);
}
userAttendantShowPics(id) {
  return request('/user/attendant/showPics', true, 'get', { id });
}
userAttendantShowPicsAdd(token, url) {
  return request('/user/attendant/showPicsAdd', true, 'post', { token, url });
}
userAttendantUpdate(data) {
  return request('/user/attendant/update', true, 'post', data);
}
shopCategory(){
  return request('/shopCategory/all', true, 'get');
}
shopCategoryDetail(id) {
  return request('/shopCategory/info', true, 'get', { id });
}
contactList() {
  return request('/contact/list', true, 'get');
}
distributedLock(key, seconds) {
  return request('/distributedLock/lock', true, 'get', { key, seconds });
}
distributedLockRelease(key) {
  return request('/distributedLock/lock', true, 'get', { key });
}
communitySetting() {
  return request('/community/setting', true, 'get');
}
communityLeaderApply(data) {
  return request('/communityLeader/apply', true, 'post', data);
}
communityLeaderApplyInfo(token) {
  return request('/communityLeader/apply/info', true, 'get', { token });
}
communityLeaderBuy(token) {
  return request('/communityLeader/buy', true, 'post', { token });
}
communityOrderFahuo(data) {
  return request('/communityOrder/fahuo', true, 'post', data);
}
wxmpOpenid(code) {
  return request('/user/wxmp/openid', true, 'get', { code });
}
listingSet() {
  return request('/listingSet/info', true, 'get');
}
listingMyListing(token) {
  return request('/listingInfo/myListing', true, 'get', { token });
}
listingSave(data) {
  return request('/listingInfo/save', true, 'post', data);
}
listingDetail(id) {
  return request('/listingInfo/detail', true, 'get', { id });
}
listingCancel(token, id) {
  return request('/listingInfo/cancel', true, 'post', { token, id });
}
listingSuccess(token, id) {
  return request('/listingInfo/success', true, 'post', { token, id });
}
listingDelete(token, id) {
  return request('/listingInfo/delete', true, 'post', { token, id });
}
listingAddGoods(data) {
  return request('/listingInfo/addGoods', true, 'post', data);
}
listingRemoveGoods(data) {
  return request('/listingInfo/removeGoods', true, 'post', data);
}
listingJoinList(data) {
  return request('/listingInfo/joinList', true, 'post', data);
}
attendantAcceptOrder(data) {
  return request('/order/acceptOrder', true, 'post', data);
}
orderCancelOrderPeriod(data) {
  return request('/order/cancelOrderPeriod', true, 'post', data);
}
orderStartOrderPeriod(data) {
  return request('/order/startOrderPeriod', true, 'post', data);
}
userAttendantOrderRejectOrder(token, orderId) {
  return request('/order/rejectOrder', true, 'post', { token, orderId });
}
userAttendantOrderServing(token, orderId) {
  return request('/order/serving', true, 'post', { token, orderId });
}
shansongCourierInfo(data) {
  return request('/order/shansongCourierInfo', true, 'get', data);
}
shansongOrderInfo(data) {
  return request('/order/shansongOrderInfo', true, 'get', data);
}
userAttendantOrderStatistics(data) {
  return request('/order/statisticsJishi', true, 'get', data);
}
keloopOrderLogs(data) {
  return request('/order/keloop/orderLogs', true, 'get', data);
}
keloopCourierTag(data) {
  return request('/order/keloop/courierTag', true, 'get', data);
}
workingHoursMySubmitLogs(data) {
  return request('/workingHours/mySubmitLogs', true, 'post', data);
}
workingHoursSubmit(data) {
  return request('/workingHours/submit', true, 'post', data);
}
workingHoursBossReport(data) {
  return request('/workingHours/bossReport', true, 'post', data);
}
workingHoursMyProject(data) {
  return request('/workingHours/myProject', true, 'post', data);
}
workingHoursProjectInfo(code) {
  return request('/workingHours/project', true, 'get', { code });
}
bestpayProCreateOrder(data) {
  return request('/pay/bestpay/proCreateOrder', true, 'post', data);
}
bestpayH5(data) {
  return request('/pay/bestpay/h5', true, 'get', data);
}
shopIotDevices(data) {
  return request('/shopIot/devices', true, 'get', data);
}
shopIotCmds(data) {
  return request('/shopIot/cmds', true, 'get', data);
}
shopIotExecute(data) {
  return request('/shopIot/execute', true, 'post', data);
}
wxTemplateNumberList(token) {
  return request('/wxTemplateNumber/list', true, 'get', { 'token': token });
}
wxTemplateNumberSubscribe(data) {
  return request('/wxTemplateNumber/subscribe', true, 'post', data);
}
errandsTaskPublish(data) {
  return request('/errandsTask/publish', true, 'post', data);
}
errandsTaskPay(data) {
  return request('/errandsTask/pay', true, 'post', data);
}
errandsTaskAccept(data) {
  return request('/errandsTask/accept', true, 'post', data);
}
errandsTaskFinish(data) {
  return request('/errandsTask/finish', true, 'post', data);
}
errandsTaskSuccess(data) {
  return request('/errandsTask/success', true, 'post', data);
}
activityVoteInfoList(data) {
  return request('/activityVoteInfo/list', true, 'post', data);
}
activityVoteInfoJoinList(data) {
  return request('/activityVoteInfo/joinList', true, 'post', data);
}
activityVoteInfoDetail(id) {
  return request('/activityVoteInfo/detail', true, 'get', { 'id': id });
}
activityVoteInfoJoinDetail(joinId) {
  return request('/activityVoteInfo/joinDetail', true, 'get', { 'joinId': joinId });
}
activityVoteInfoScoreToVotes(activityId) {
  return request('/activityVoteInfo/scoreToVotes', true, 'get', { 'activityId': activityId });
}
activityVoteInfoFetchVoteNumber(data) {
  return request('/activityVoteInfo/fetchVoteNumber', true, 'post', data);
}
activityVoteInfoJoin(data) {
  return request('/activityVoteInfo/join', true, 'post', data);
}
activityVoteInfoVote(data) {
  return request('/activityVoteInfo/vote', true, 'post', data);
}
activityVoteBlance(token, activityId) {
  return request('/activityVoteInfo/balance', true, 'get', { 'token': token, 'activityId': activityId });
}
stringsToPlainText(content, [len]) {
  return request('/common/strings/plainText', true, 'post', { 'content': content, 'len': len });
}
blindBoxFriendsMatch(data) {
  return request('/blindBoxFriends/match', true, 'post', data);
}
blindBoxFriendsPush(data) {
  return request('/blindBoxFriends/push', true, 'post', data);
}
blindBoxFriendsPay(data) {
  return request('/blindBoxFriends/pay', true, 'post', data);
}
blindBoxFriendsChangeStatus(data) {
  return request('/blindBoxFriends/changeStatus', true, 'post', data);
}
blindBoxFriendsDelete(data) {
  return request('/blindBoxFriends/delete', true, 'post', data);
}
blindBoxFriendsPullLogs(data) {
  return request('/blindBoxFriends/pullLogs', true, 'post', data);
}
blindBoxFriendsPushLogs(data) {
  return request('/blindBoxFriends/pushLogs', true, 'post', data);
}
blindBoxFriendsRechargeRule() {
  return request('/blindBoxFriends/rechargeRule', true, 'get');
}
blindBoxFriendsBuyPullTimes(data) {
  return request('/blindBoxFriends/buyPullTimes', true, 'post', data);
}
blindBoxFriendsUnlock(data) {
  return request('/blindBoxFriends/unlock', true, 'post', data);
}
blindBoxFriendsBalance(token) {
  return request('/blindBoxFriends/balance', true, 'get', { 'token': token })
}
cpactivityInfoDetail(id) {
  return request('/cpactivityInfo/detail', true, 'get', { id });
}
cpactivityJoinDetail(data) {
  return request('/cpactivityInfo/join', true, 'get', data);
}
cpactivityJoin(data) {
  return request('/cpactivityInfo/join', true, 'post', data);
}
cpactivityJoinDynamics(cpactivityId) {
  return request('/cpactivityInfo/joinDynamics', true, 'get', { 'cpactivityId': cpactivityId });
}
cpactivityPay(data) {
  return request('/cpactivityInfo/pay', true, 'post', data);
}