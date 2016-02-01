//
//  RedditPost.h
//  RedditReader
//
//  Created by Everett Gilmore on 1/29/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RedditPost : NSObject

@property (nonatomic) NSDictionary *thePost;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *subreddit;
@property (nonatomic) NSString *author;
@property (nonatomic) NSNumber *score;
@property (nonatomic) NSNumber *numberOfComments;
@property (nonatomic) NSString *thumbnailURL;
@property (nonatomic) NSString *createdAtUTC;


-(instancetype)initWithDictionary: (NSDictionary *)thePost;
@end
