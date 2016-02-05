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
#import "PostDetailViewController.h"

@interface PostsTableViewController () <PostsTableViewCellDelegate>
@property (nonatomic) NSArray * posts;
@property (nonatomic) NSString *selectedURL;
@property (nonatomic) NSMutableArray *history;

@end

@implementation PostsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.title = self.selectedSubreddit;
    self.history = [[NSMutableArray alloc] init];
    
    __weak typeof(self)weakSelf = self;
    [[RedditAPI sharedAPI] getPostsForSubReddit:self.selectedSubreddit completion:^(NSArray *posts, NSError *error) {
        __typeof__(self) strongSelf = weakSelf;
        strongSelf.posts = posts;
        [strongSelf.tableView reloadData];
    }];
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
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
    cell.delegate = self;
    
    cell.thePost = post;
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
    NSString * pLink = [NSString stringWithFormat:@"https://www.reddit.com%@.compact", post.permalink];
    if ([self.history containsObject:post.URL] || [self.history containsObject:pLink]) {
        cell.title.textColor = [UIColor lightGrayColor];
        cell.subreddit.textColor = [UIColor lightGrayColor];
        cell.score.textColor = [UIColor lightGrayColor];
        
    
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


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RedditPost *post = [[RedditPost alloc] initWithDictionary:[self.posts objectAtIndex:indexPath.row]];
    if([post.URL isEqualToString:[NSString stringWithFormat:@"https://www.reddit.com%@", post.permalink]]){
        self.selectedURL = [NSString stringWithFormat:@"https://www.reddit.com%@.compact", post.permalink];
    }else{
        self.selectedURL = post.URL;
    }
    [self.history insertObject:self.selectedURL atIndex:0];
    [self performSegueWithIdentifier:@"post" sender:self];
}

-(void)didTapCommentsButtonOnCell:(PostsTableViewCell *)cell{
    
    RedditPost *post = [[RedditPost alloc] initWithDictionary:cell.thePost.thePost];
    self.selectedURL = [NSString stringWithFormat:@"https://www.reddit.com%@.compact", post.permalink];
    [self.history insertObject:self.selectedURL atIndex:0];
    [self performSegueWithIdentifier:@"comments" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"post"])
    {
        PostDetailViewController *vc = (PostDetailViewController*)[segue destinationViewController];
        vc.selectedURL = self.selectedURL;
        vc.history = self.history;
    }
    else if([[segue identifier] isEqualToString:@"comments"]){
        PostDetailViewController *vc = (PostDetailViewController*)[segue destinationViewController];
        vc.selectedURL = self.selectedURL;
        
    }
}


@end
