//
//  Tools.h
//  youche
//
//  Created by Alvin.liu on 12-11-8.
//
//

#import <Foundation/Foundation.h>
#import "NewsModel.h"

@interface Tools : NSObject


/**
 * 通过整值获得格式化时间字符串
 * @param dateline 整数时间线
 */
+ (NSString *)getFormateDate:(int)dateline;

/**
 * 重复判断方法
 */

//判断文章是否重复
+ (BOOL)isRepeatNews:(NSMutableArray *)all andNews:(NewsModel *)n;

//解析文章
+ (NSMutableArray *)readStrNewsArray:(NSString *)str andOld:(NSMutableArray *)olds;


@end
