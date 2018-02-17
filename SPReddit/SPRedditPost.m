//
//  SPRedditPost.m
//  SPReddit
//
//  Created by Steven Petteruti on 2/15/18.
//  Copyright © 2018 Steven Petteruti. All rights reserved.
//

#import "SPRedditPost.h"

@implementation SPRedditPost

- (instancetype)initWithName:(NSString *)name andThumbnailUrl:(NSString *)thumbnailUrl andUrl:(NSString *)url andComments:(int)comments andContent:(NSString *)content andSecondsAgo:(float)seconds;
{
    self = [super init];
    if (self != nil)
    {
        // Further initialization if needed
        _name = name;
        _thumbnailUrl = thumbnailUrl;
        _url = url;
        _comments = comments;
        _content = content;
        _secondsAgo = seconds;
    }
    return self;
}

@end
