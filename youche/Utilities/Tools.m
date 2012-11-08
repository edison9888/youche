//
//  Tools.m
//  youche
//
//  Created by Alvin.liu on 12-11-8.
//
//

#import "Tools.h"

@implementation Tools


/**
 * 通过整值获得格式化时间字符串
 * @param dateline 整数时间线 //yyyy-MM-dd HH:mm:ss.SSS
 */
+ (NSString *)getFormateDate:(int)dateline
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:dateline];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormater stringFromDate:date];
}

//判断新闻是否重复
+ (BOOL)isRepeatNews:(NSMutableArray *)all andNews:(NewsModel *)n
{
    if (all == nil) {
        return NO;
    }
    for (NewsModel * _n in all) {
        if (_n.articleid == n.articleid) {
            return YES;
        }
    }
    return NO;
}

//解析文章
+ (NSMutableArray *)readStrNewsArray:(NSString *)str andOld:(NSMutableArray *)olds
{
    
    TBXML *xml = [[TBXML alloc] initWithXMLString:str error:nil];
    TBXMLElement *root = xml.rootXMLElement;
    NSMutableArray *news = [[NSMutableArray alloc] initWithCapacity:20];
    if (!root) {
        return nil;
    }
    //显示
    TBXMLElement *article = [TBXML childElementNamed:@"article" parentElement:root];
    if (!article) {
        return nil;
    }
    
    TBXMLElement *articleid = [TBXML childElementNamed:@"articleid" parentElement:article];
    TBXMLElement *dateline = [TBXML childElementNamed:@"dateline" parentElement:article];
    TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:article];
    TBXMLElement *subject = [TBXML childElementNamed:@"subject" parentElement:article];
    TBXMLElement *grade = [TBXML childElementNamed:@"grade" parentElement:article];
    TBXMLElement *digg = [TBXML childElementNamed:@"digg" parentElement:article];
    TBXMLElement *comments = [TBXML childElementNamed:@"comments" parentElement:article];
    TBXMLElement *copyfrom = [TBXML childElementNamed:@"copyfrom" parentElement:article];
    TBXMLElement *thumb = [TBXML childElementNamed:@"thumb" parentElement:article];

    int newid = [[TBXML textForElement:articleid] intValue];
    int newdate = [[TBXML textForElement:dateline] intValue];
    NSString *newauthor = [TBXML textForElement:author];
    NSString *newsubject = [TBXML textForElement:subject];
    int newgrade = [[TBXML textForElement:grade] intValue];
    int newdigg = [[TBXML textForElement:digg] intValue];
    int newcomments = [[TBXML textForElement:comments] intValue];
    NSString *newcopyfrom = [TBXML textForElement:copyfrom];
    NSString *newthumb = [TBXML textForElement:thumb];
    
    
    NewsModel *n = [[NewsModel alloc] initWithParameters:newid
                                                    date:newdate
                                                  author:newauthor
                                                   title:newsubject
                                                   grade:newgrade
                                                    digg:newdigg
                                            commentCount:newcomments
                                                copyfrom:newcopyfrom
                                                   thumb:newthumb];
    
    if (![Tools isRepeatNews:olds andNews:n]) {
        [news addObject:n];
    }
    
    while (article != nil) {
        article = [TBXML nextSiblingNamed:@"article" searchFromElement:article];
        if (article) {
            
            TBXMLElement *articleid = [TBXML childElementNamed:@"articleid" parentElement:article];
            TBXMLElement *dateline = [TBXML childElementNamed:@"dateline" parentElement:article];
            TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:article];
            TBXMLElement *subject = [TBXML childElementNamed:@"subject" parentElement:article];
            TBXMLElement *grade = [TBXML childElementNamed:@"grade" parentElement:article];
            TBXMLElement *digg = [TBXML childElementNamed:@"digg" parentElement:article];
            TBXMLElement *comments = [TBXML childElementNamed:@"comments" parentElement:article];
            TBXMLElement *copyfrom = [TBXML childElementNamed:@"copyfrom" parentElement:article];
            TBXMLElement *thumb = [TBXML childElementNamed:@"thumb" parentElement:article];
            
            
            int newid = [[TBXML textForElement:articleid] intValue];
            int newdate = [[TBXML textForElement:dateline] intValue];
            NSString *newauthor = [TBXML textForElement:author];
            NSString *newsubject = [TBXML textForElement:subject];
            int newgrade = [[TBXML textForElement:grade] intValue];
            int newdigg = [[TBXML textForElement:digg] intValue];
            int newcomments = [[TBXML textForElement:comments] intValue];
            NSString *newcopyfrom = [TBXML textForElement:copyfrom];
            NSString *newthumb = [TBXML textForElement:thumb];
            
            NewsModel *n = [[NewsModel alloc] initWithParameters:newid
                                                            date:newdate
                                                          author:newauthor
                                                           title:newsubject
                                                           grade:newgrade
                                                            digg:newdigg
                                                    commentCount:newcomments
                                                        copyfrom:newcopyfrom
                                                           thumb:newthumb];
            
            if (![Tools isRepeatNews:olds andNews:n]) {
                [news addObject:n];
            }
        }
        else
        {
            break;
        }
    }
    return news;
}

@end
