//
//  EJSPhoto.m
//  AstronomyPictureOfTheDay
//
//  Created by Enzo Jimenez-Soto on 7/23/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import "EJSPhoto.h"

@implementation EJSPhoto

- (instancetype)initWithTitle:(NSString *)title explanation:(NSString *)explanation date:(NSDate *)date url:(NSURL *)url
{
    self = [super init];
    if (self) {
        
        _title = title;
        _explanation = explanation;
        _date = date;
        _url = url;
    }
    
    return self;
}
@end
