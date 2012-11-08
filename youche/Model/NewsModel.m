//
//  NewsModel.m
//  youche
//
//  Created by Alvin.liu on 12-11-8.
//
//

#import "NewsModel.h"

@implementation NewsModel

@synthesize articleid;
@synthesize dateline;
@synthesize author;
@synthesize articleTitle;
@synthesize grade;
@synthesize digg;
@synthesize commentCount;
@synthesize copyfrom;
@synthesize thumb;


- (id)initWithParameters:(int)newsid
                    date:(int)newDate
                  author:(NSString *)newAuthor
                   title:(NSString *)newTitle
                   grade:(int)newGrade
                    digg:(int)newDigg
            commentCount:(int)newCount
                copyfrom:(NSString *)newFrom
                   thumb:(NSString *)newThumb{

    NewsModel *news = [[NewsModel alloc] init];
    news.articleid = newsid;
    news.dateline = newDate;
    news.author = newAuthor;
    news.articleTitle = newTitle;
    news.grade = newGrade;
    news.digg = newDigg;
    news.commentCount = newCount;
    news.copyfrom = newFrom;
    news.thumb = newThumb;
    
    return news;
}


@end
