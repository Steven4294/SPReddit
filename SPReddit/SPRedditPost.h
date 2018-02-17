//
//  SPRedditPost.h
//  SPReddit
//
//  Created by Steven Petteruti on 2/15/18.
//  Copyright © 2018 Steven Petteruti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPRedditPost : NSObject


@property NSString *name;
@property NSString *thumbnailUrl; // the url of just the thumbnail
@property NSString *url; // the full url
@property NSString *content;

@property int comments;
@property float secondsAgo;

- (instancetype)initWithName:(NSString *)name andThumbnailUrl:(NSString *)thumbnailUrl andUrl:(NSString *)url andComments:(int)comments andContent:(NSString *)content andSecondsAgo:(float)seconds;


@end
