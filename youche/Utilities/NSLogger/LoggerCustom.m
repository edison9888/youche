//
//  LoggerCustom.m
//  ChinaMobileHolidayDev
//
//  Created by Coolin 006 on 12-11-13.
//  Copyright (c) 2012年 Coolinsoft. All rights reserved.
//

#import "LoggerCustom.h"

//@implementation LoggerCustom
//
//@end


void LogImage(NSString *domain, int level, UIImage *img)
{
    int width = 100;
    int height = 100;
    NSData *data = UIImagePNGRepresentation(img);
	LogImageTo_internal(NULL, NULL, 0, NULL, domain, level, width, height, data);
}