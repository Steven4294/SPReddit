//
//  SPObjectManager.m
//  SPReddit
//
//  Created by Steven Petteruti on 2/15/18.
//  Copyright © 2018 Steven Petteruti. All rights reserved.
//

#import "SPObjectManager.h"
#import "SBJson5.h"
#import "SPRedditPost.h"

@implementation SPObjectManager

+ (id)sharedManager {
    static SPObjectManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)fetchDataWithCallback:(void (^)(NSArray *, NSError *))aCallback{
    
    // making a GET request to /init
    NSString *targetUrl = [NSString stringWithFormat:@"https://www.reddit.com/top/.json?count=50"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    
    // parsing blocks
    SBJson5ValueBlock block = ^(id v, BOOL *stop) {
        if ([v isKindOfClass:[NSMutableDictionary class]]) {

            NSArray *payload  = v[@"data"][@"children"];
            
            NSMutableArray *posts = [[NSMutableArray alloc] init];

            for (id object in payload) {
                
                CGFloat createdAt = [object[@"data"][@"created_utc"] floatValue];
                NSDate *now = [NSDate date];
                CGFloat nowEpochSeconds = [now timeIntervalSince1970];
                CGFloat secondsAgo = nowEpochSeconds -  createdAt;
                
                
                SPRedditPost *post = [[SPRedditPost alloc] initWithName:object[@"data"][@"author"]
                                                        andThumbnailUrl:object[@"data"][@"thumbnail"]
                                                                 andUrl:object[@"data"][@"url"]
                                                            andComments:[object[@"data"][@"num_comments"] intValue]
                                                             andContent:object[@"data"][@"title"]
                                                          andSecondsAgo:secondsAgo];


                [posts addObject:post];
            }
        
            aCallback([posts copy], nil); //copy creates an immutable version (since we want an NSArray and not an NSMutableArray)
            
        }
    };
    
    SBJson5ErrorBlock eh = ^(NSError* err) {
        aCallback(nil, err);
    };
    
    
    // create a url request
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          // parse the data into a nsdictionary
          id parser = [SBJson5Parser parserWithBlock:block
                                        errorHandler:eh];
          
          [parser parse:data];
          
      }] resume];
    
}

@end
