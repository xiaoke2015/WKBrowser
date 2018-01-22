//
//  NSString+SubString.h
//  WKBrowser
//
//  Created by 李加建 on 2017/12/1.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  判断是否是空字符串 空字符串 = yes
 *
 *  @param string
 *
 *  @return
 */
#define  IsEmptyStr(string) string == nil || string == NULL ||[string isKindOfClass:[NSNull class]]|| [string isEqualToString:@""] ||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 ? YES : NO



@interface NSString (SubString)

- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString ;

@end
