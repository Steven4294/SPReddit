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

// gets the first 25 posts from reddit.com/top
- (void)fetchDataWithCallback:(void (^)(NSArray *, NSError *))aCallback;

// gets the next 5 posts after an image Id
- (void)fetchDataWithCallback:(void (^)(NSArray *, NSError *))aCallback afterId:(NSString *)name;



@end
