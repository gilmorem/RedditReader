//
//  RedditAPI.h
//  RedditReader
//
//  Created by Everett Gilmore on 1/29/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedditAPI : NSObject

+ (instancetype)sharedAPI;

-(void)getPostsForSubReddit: (NSString *)subReddit completion:(void(^)(NSArray *posts, NSError *error))completion;

@end
