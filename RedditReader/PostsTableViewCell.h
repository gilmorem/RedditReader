//
//  PostsTableViewCell.h
//  RedditReader
//
//  Created by Everett Gilmore on 1/29/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedditPost.h"


@class PostsTableViewCell;
@protocol PostsTableViewCellDelegate <NSObject>

@optional
- (void) didTapCommentsButtonOnCell:(PostsTableViewCell *) cell;
@end

@interface PostsTableViewCell : UITableViewCell

@property(nonatomic)RedditPost * thePost;

@property (nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UIButton *numComments;
@property (strong, nonatomic) IBOutlet UILabel *subreddit;

@property (unsafe_unretained) id <PostsTableViewCellDelegate> delegate;

@end
