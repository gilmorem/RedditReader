//
//  RedditPost.m
//  RedditReader
//
//  Created by Everett Gilmore on 1/29/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import "RedditPost.h"



@implementation RedditPost

-(instancetype)initWithDictionary: (NSDictionary *)thePost{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.thePost = thePost;
    
    self.title = [self.thePost objectForKey:@"title"];
    self.subreddit = [self.thePost objectForKey:@"subreddit"];
    self.author = [self.thePost objectForKey:@"author"];
    self.score = [self.thePost objectForKey:@"score"];
    self.numberOfComments = [self.thePost objectForKey:@"num_comments"];
    self.thumbnailURL = [self.thePost objectForKey:@"thumbnail"];
    self.createdAtUTC = [self.thePost objectForKey:@"created_utc"];
    self.URL = [self.thePost objectForKey:@"url"];
    self.permalink = [self.thePost objectForKey:@"permalink"];
    
    return self;
}


@end
