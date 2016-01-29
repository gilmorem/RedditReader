//
//  PostsTableViewCell.h
//  RedditReader
//
//  Created by Everett Gilmore on 1/29/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;


@end
