//
//  NewsModel.h
//  youche
//
//  Created by Alvin.liu on 12-11-8.
//
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property int articleid;        //文章id
@property int dateline;         //发布时间
@property (nonatomic,copy) NSString * author;       //作者
@property (nonatomic,copy) NSString * articleTitle; //标题
@property int grade;    //评分
@property int digg;     //支持数
@property int commentCount; //评论数
@property (nonatomic,copy) NSString * copyfrom;     //文章来源
@property (nonatomic,copy) NSString * thumb;        //缩略图


- (id)initWithParameters:(int)newsid
                    date:(int)newDate
                  author:(NSString *)newAuthor
                   title:(NSString *)newTitle
                   grade:(int)newGrade
                    digg:(int)newDigg
            commentCount:(int)newCount
                copyfrom:(NSString *)newFrom
                   thumb:(NSString *)newThumb;

@end
