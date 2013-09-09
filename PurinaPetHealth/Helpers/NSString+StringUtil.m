//
// Created by craigclayton on 12/5/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSString+StringUtil.h"


@implementation NSString (StringUtil)



+ (NSString *)capitalizedFirstCharacter:(NSString *)str
{
    str = [str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] uppercaseString]];
    return str;
}



@end