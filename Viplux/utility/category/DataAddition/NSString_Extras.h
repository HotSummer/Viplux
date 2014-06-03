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

#import <Foundation/Foundation.h>


@interface  NSString(Extras)


+ (id)tryStringWithCString:(const char *)cString encoding:(NSStringEncoding)enc;

- (NSString*)stringWithPercentEscape;

- (NSString *)MD5Hash;

- (Boolean) containsString: (NSString *)subString;

- (NSString *)htmlEntityDecode;

- (NSString *)getString;

- (NSArray *)componentsSeparated;
@end
