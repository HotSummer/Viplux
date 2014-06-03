/************ ************************************************************
 *                                                                                                                                                                                            *
 * Copyright (C) 2009 GeoSolutions, BV                                                                                                                  
 * All Rights Reserved.                                                                                                                                                   
 *                                                                                                                                                                                            *
 * This software is the property of GeoSolutions, BV.                                                                                      
 * No part of this application may be copied, in any form, without the                                                     
 * express written permission of GeoSolutions.                                                                                                 
 *                                                                                                                                                                                            *
 *************************************************************************/

#import "NSString_Extras.h"
#import "CommonCrypto/CommonDigest.h"
#import "NSObject+Addtions.h"

@implementation NSString(Extras)


+ (id)tryStringWithCString:(const char *)cString encoding:(NSStringEncoding)enc
{
	if(cString)
	{
		return [NSString stringWithCString:cString encoding:enc];
	}
	else
	{
		return @"";
	}
}


- (NSString*)stringWithPercentEscape {
    return [(NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[[self mutableCopy] autorelease], NULL, CFSTR("￼=,!$&'()*+;@?\n\"<>#\t :/"),kCFStringEncodingUTF8) autorelease];
}

- (NSString *)MD5Hash {
    const char* cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
	
    CC_MD5( cStr, strlen(cStr), result );
	
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (Boolean) containsString: (NSString *)subString{
    NSRange rangeValue = [self rangeOfString: subString options:NSCaseInsensitiveSearch];
    return rangeValue.length >0;
}

//http://pastebin.com/uVb3SKHK
-(NSString*) htmlEntityDecode{
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", charCode];
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                //[scanner scanUpToString:@";" intoString:&unknownEntity];
                //[result appendFormat:@"&#%@%@;", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
            
        }
        else {
            NSString *amp;
            //an isolated & symbol
            [scanner scanString:@"&" intoString:&amp];
            [result appendString:amp];
        }
    }
    while (![scanner isAtEnd]);
    
finish:
    return result;
}

- (NSString *)getString
{
    if ([self stringCheck])return self;
    return @"";
}

- (NSMutableArray *)componentsSeparated{
    if (self.length > 0) {
        NSMutableArray *arrOrg = [[NSMutableArray alloc] init];
        int iLength = self.length;
        int i=0;
        while (i<iLength) {
            NSString *str = [self substringWithRange:NSMakeRange(i, 1)];
            [arrOrg addObject:str];
            i++;
        }
        return arrOrg;
    }
    return nil;
}

@end