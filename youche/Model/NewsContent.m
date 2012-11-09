//
//  NewsContent.m
//  youche
//
//  Created by Coolin 006 on 12-11-9.
//
//

#import "NewsContent.h"

@implementation NewsContent

@synthesize articleid;
@synthesize content;


- (id)initWithParameters:(int)newid
                 content:(NSString *)newContent
{
    
    NewsContent *news = [[NewsContent alloc] init];
    news.articleid = newid;
    news.content = newContent;
    
    return news;
}


@end
