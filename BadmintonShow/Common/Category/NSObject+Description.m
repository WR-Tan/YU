//
//  NSObject+Description.m
//  QZone
//
//  Created by wihing on 14-3-7.
//  Copyright (c) 2014年 wihing. All rights reserved.
//

#import "NSObject+Description.h"
#include <objc/objc.h>
#include <objc/runtime.h>
#include <objc/message.h>

@implementation NSObject (Description)

- (NSString *)propertiesDescription {
	return [self propertiesDescription:[self class]];
}

- (NSString *)propertiesDescription:(Class )objClass
{
    NSMutableString *descriptionString = [[NSMutableString alloc] init];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(objClass, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; i++)
    {
        NSString *selector = [NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding] ;
        SEL sel = sel_registerName([selector UTF8String]);
        
        const char *rawAttributeString = property_getAttributes(properties[i]);
        NSString* attributeString = [NSString stringWithUTF8String:rawAttributeString];
        NSArray* attributeArray = [attributeString componentsSeparatedByString:@","];
        NSString* attributeType = [attributeArray objectAtIndex:0];
        NSString* propertyType = [attributeType substringFromIndex:1];
        const char * rawPropertyType = [propertyType UTF8String];
        
        NSString *formatString = @"";
        if (strcmp(rawPropertyType, @encode(char)) == 0) {
            formatString = @"%s : %d\n";
        } else if (strcmp(rawPropertyType, @encode(unsigned char)) == 0) {
            formatString = @"%s : %u\n";
        } else if (strcmp(rawPropertyType, @encode(short)) == 0) {
            formatString = @"%s : %d\n";
        } else if (strcmp(rawPropertyType, @encode(unsigned short)) == 0) {
            formatString = @"%s : %u\n";
        } else if (strcmp(rawPropertyType, @encode(int)) == 0) {
            formatString = @"%s : %d\n";
        } else if (strcmp(rawPropertyType, @encode(unsigned int)) == 0) {
            formatString = @"%s : %u\n";
        } else if (strcmp(rawPropertyType, @encode(long)) == 0) {
            formatString = @"%s : %d\n";
        } else if (strcmp(rawPropertyType, @encode(unsigned long)) == 0) {
            formatString = @"%s : %u\n";
        } else if (strcmp(rawPropertyType, @encode(long long)) == 0) {
            formatString = @"%s : %qi\n";
        } else if (strcmp(rawPropertyType, @encode(unsigned long long)) == 0) {
            formatString = @"%s : %qu\n";
        } else if (strcmp(rawPropertyType, @encode(short)) == 0) {
            formatString = @"%s : %f\n";
        } else if (strcmp(rawPropertyType, @encode(double)) == 0) {
            formatString = @"%s : %f\n";
        } else if ([propertyType hasPrefix:@"@"]) {
            formatString = @"%s : %@\n";
        } else {
            continue;
        }
        
        [descriptionString insertString:[NSString stringWithFormat:formatString, property_getName(properties[i]), [self performSelector:sel]] atIndex:0];
    }
    
    free(properties);
    
    return descriptionString;
}

@end
