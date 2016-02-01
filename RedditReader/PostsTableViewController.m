//
//  PostsTableViewController.m
//  RedditReader
//
//  Created by Everett Gilmore on 1/29/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import "PostsTableViewController.h"
#import "RedditAPI.h"
#import "PostsTableViewCell.h"
#import "RedditPost.h"

@interface PostsTableViewController ()
@property (nonatomic) NSArray * posts;


@end

@implementation PostsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.title = self.selectedSubreddit;
    
    [[RedditAPI sharedAPI] getPostsForSubReddit:self.selectedSubreddit completion:^(NSArray *posts, NSError *error) {
        self.posts = posts;
        [self.tableView reloadData];
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   
    if(!self.posts){
         return 0;
    }else{
        return [self.posts count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    RedditPost *post = [[RedditPost alloc] initWithDictionary:[self.posts objectAtIndex:indexPath.row]];
   
    cell.title.text = post.title;
    cell.subreddit.text = [NSString stringWithFormat:@"%@ • %@", post.subreddit, post.author];
    [cell.numComments setTitle:[NSString stringWithFormat:@"%@", post.numberOfComments] forState:UIControlStateNormal];
    NSString * epochDate = post.createdAtUTC;
    cell.score.text = [NSString stringWithFormat:@"%@ ⚬ %@", post.score, [self timeAgo:epochDate]];
    NSURL *imageURL = [NSURL URLWithString:post.thumbnailURL];
    NSError *error = nil;
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL options:NSDataReadingUncached error:&error];
    UIImage *image = [UIImage imageWithData:imageData];
    
    if (error) {
       NSLog(@"%@", [error localizedDescription]);
    } else {
        NSLog(@"Data has loaded successfully.");
    }
    cell.thumbnailImageView.image = image;
    

    
    if (!cell.thumbnailImageView.image) {
        cell.thumbnailImageView.image = [UIImage imageNamed:@"alien.png"];
    }
    
    return cell;
}

static int const MINUTE = 60;
static int const HOUR = (MINUTE * 60);
static int const DAY = (HOUR * 24);
static int const WEEK = (DAY * 7);
static int const MONTH = (DAY * 31);
static int const YEAR = (DAY * 365);

- (NSString*)timeAgo: (NSString *)epochTime {
    
    NSTimeInterval seconds = [epochTime doubleValue];
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    
    NSDate *now = [NSDate date];
    NSInteger secondsSinceNow = (NSInteger)[now timeIntervalSinceDate:epochNSDate];
    
    
    NSInteger prefix = 0;
    NSString *suffix = nil;
    
    // Seconds
    if (secondsSinceNow < MINUTE) {
        prefix = secondsSinceNow;
        suffix = @"s";
    }
    // Minute
    else if (secondsSinceNow < HOUR) {
        prefix = secondsSinceNow / MINUTE;
        suffix = @"m";
    }
    // Hour
    else if (secondsSinceNow < DAY) {
        prefix = secondsSinceNow / HOUR;
        suffix = @"h";
    }
    // Day
    else if (secondsSinceNow < WEEK) {
        prefix = secondsSinceNow / DAY;
        suffix = @"d";
    }
    // Week
    else if (secondsSinceNow < MONTH) {
        prefix = secondsSinceNow / WEEK;
        suffix = @"w";
    }
    // Month
    else if (secondsSinceNow < YEAR) {
        prefix = secondsSinceNow / MONTH;
        suffix = @"mo";
    }
    // Year
    else {
        prefix = secondsSinceNow / YEAR;
        suffix = @"y";
    }
    
    return [NSString stringWithFormat:@"%ld%@", (long)prefix, suffix];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
