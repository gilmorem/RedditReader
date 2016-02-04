//
//  PostsTableViewCell.m
//  RedditReader
//
//  Created by Everett Gilmore on 1/29/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import "PostsTableViewCell.h"

@implementation PostsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.numComments addTarget:self action:@selector(pressedCommentsButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pressedCommentsButton:(UIButton *)sender
{
    [self.delegate didTapCommentsButtonOnCell:self];
}

@end
