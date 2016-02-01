//
//  SubredditsTableViewController.m
//  RedditReader
//
//  Created by Everett Gilmore on 2/1/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import "SubredditsTableViewController.h"
#import "SubredditTableViewCell.h"
#import "PostsTableViewController.h"

@interface SubredditsTableViewController ()
@property (nonatomic) NSArray *subredditsArray;
@property (nonatomic) NSString *selectedSubreddit;
@end

@implementation SubredditsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.subredditsArray = [[NSArray alloc] initWithObjects:@"iOSProgramming", @"Xboxone", nil];
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

    return [self.subredditsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     SubredditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subredditCell" forIndexPath:indexPath];
    
    cell.subreddit.text = [self.subredditsArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedSubreddit = [self.subredditsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"subreddit" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if ([[segue identifier] isEqualToString:@"subreddit"])
    {
        PostsTableViewController *vc = (PostsTableViewController*)[segue destinationViewController];
        vc.selectedSubreddit = self.selectedSubreddit;
    }
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
