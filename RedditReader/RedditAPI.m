//
//  RedditAPI.m
//  RedditReader
//
//  Created by Everett Gilmore on 1/29/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import "RedditAPI.h"
#import <AFNetworking/AFNetworking.h>


@interface RedditAPI ()

@property (nonatomic) AFHTTPSessionManager *manager;

@end

@implementation RedditAPI

-(instancetype)init{
    self = [super init];
    
    if (self){
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://www.reddit.com"]];
    }
    
    return self;
}


-(void)getPostsForSubReddit: (NSString *)subReddit completion:(void(^)(NSArray *posts, NSError *error))completion{
    
    NSString *url = [NSString stringWithFormat:@"/r/%@.json", subReddit];
    
    
    [self.manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray * postObjects = responseObject[@"data"][@"children"];
        NSMutableArray *posts = [[NSMutableArray alloc] init];
        
        for (NSDictionary *postObject in postObjects) {
            NSDictionary *post = postObject[@"data"];
            [posts addObject:post];
        }
        
        completion(posts, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        completion(nil, error);
        
    }];
    
}

+ (instancetype)sharedAPI{
    
    static RedditAPI *sharedAPI;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedAPI = [[RedditAPI alloc] init];
    });
    
    return sharedAPI;
}



@end
