//
//  NewsContent.h
//  youche
//
//  Created by Coolin 006 on 12-11-9.
//
//

#import <Foundation/Foundation.h>

@interface NewsContent : NSObject

@property int articleid;  //文章id
@property (nonatomic,copy) NSString * content;        //文章内容


- (id)initWithParameters:(int)newid
                 content:(NSString *)newContent;


@end
