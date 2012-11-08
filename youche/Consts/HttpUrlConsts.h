//
//  HttpUrlConsts.h
//  youchezx
//
//  Created by Alvin.liu on 12-11-1.
//
//

#ifndef oschina_HttpUrlConsts_h
#define oschina_HttpUrlConsts_h


/*Server root*/
//#define kServerRoot             @"http://192.168.0.107/md/server/"
#define kServerRoot             @"http://localhost/dp/server/"


/**
 * Server API
 */

//获取地区列表
#define kAPIGetArea             @"getAreaList.php"
//获取文章分类
#define kAPIGetArticleCat       @"getArticleCat.php"
//获取文章列表
#define kAPIGetArticlesList     @"getArticlesList.php"
//获取文章内容
#define kAPIGetArticles         @"getArticles.php"
//获取评论内容
#define kAPIGetComments         @"getComments.php"


//获取主题（4s）分类
#define kAPIGetSubjectCat       @"getSubjectCat.php"
//获取主题（4s）列表
#define kAPIGetSubjectsList     @"getSubjectsList.php"
//获取主题（4s）内容
#define kAPIGetsubjectsDetail   @"getSubjectsDetail.php"

//获取优惠分类
#define kAPIGetCouponsCat       @"getCouponsCat.php"
//获取优惠信息
#define kAPIGetCoupons          @"getCoupons.php"





#endif
