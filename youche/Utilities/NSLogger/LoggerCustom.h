//
//  LoggerCustom.h
//  ChinaMobileHolidayDev
//
//  Created by liuLei on 12-11-13.
//  Copyright (c) 2012年 Coolinsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface LoggerCustom : NSObject
//
//@end

#import <UIKit/UIKit.h>
#import "LoggerClient.h"


#ifdef __cplusplus
extern "C" {
#endif

extern void LogImage(NSString *domain, int level, UIImage *img);


#ifdef __cplusplus
};
#endif