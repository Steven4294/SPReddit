//
//  SPObjectManager.h
//  SPReddit
//
//  Created by Steven Petteruti on 2/15/18.
//  Copyright © 2018 Steven Petteruti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPObjectManager : NSObject

+ (id)sharedManager;

- (void)fetchDataWithCallback:(void (^)(NSArray *, NSError *))aCallback;


@end
