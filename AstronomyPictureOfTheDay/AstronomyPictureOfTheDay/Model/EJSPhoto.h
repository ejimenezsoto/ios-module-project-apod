//
//  EJSPhoto.h
//  AstronomyPictureOfTheDay
//
//  Created by Enzo Jimenez-Soto on 7/23/20.
//  Copyright © 2020 Enzo Jimenez-Soto. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EJSPhoto : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *explanation;
@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, readonly) NSURL *url;

- (instancetype)initWithTitle:(NSString *)title explanation:(NSString *)explanation date:(NSDate *)date url:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
