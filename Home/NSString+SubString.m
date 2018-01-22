//
//  NSString+SubString.m
//  WKBrowser
//
//  Created by 李加建 on 2017/12/1.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "NSString+SubString.h"

@implementation NSString (SubString)


- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString
{
    if (IsEmptyStr(fromString) || IsEmptyStr(toString)) {
        return nil;
    }
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = self;
    NSRange range = [tempString rangeOfString:fromString];
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }
        else
        {
            break;
        }
    }
    return subStringsArray;
}


@end
