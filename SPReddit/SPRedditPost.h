//
//  SPRedditPost.h
//  SPReddit
//
//  Created by Steven Petteruti on 2/15/18.
//  Copyright © 2018 Steven Petteruti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPRedditPost : NSObject

@property NSString *name; // this is the id we'll have to reference for pagination
@property NSString *author;
@property NSString *thumbnailUrl; // the url of just the thumbnail
@property NSString *url; // the full url
@property NSString *content;

@property int comments;
@property float secondsAgo;

- (instancetype)initWithAuthor:(NSString *)author andThumbnailUrl:(NSString *)thumbnailUrl andUrl:(NSString *)url andComments:(int)comments andContent:(NSString *)content andSecondsAgo:(float)seconds andName:(NSString *)name;


@end
