//
//  PostDetailViewController.m
//  RedditReader
//
//  Created by Everett Gilmore on 2/3/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import "PostDetailViewController.h"
#import <SpinKit/RTSpinKitView.h>

@interface PostDetailViewController () <UIWebViewDelegate>
@property (nonatomic) UIWebView *webView;
@property (nonatomic) RTSpinKitView *spinner;
@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.webView = [[UIWebView alloc]
                     initWithFrame:self.view.frame];
    self.webView.delegate = self;
    
    self.spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePulse];
    self.spinner.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - self.navigationController.navigationBar.frame.size.height, 100, 100);
    self.spinner.spinnerSize = 100.0;
    self.spinner.color = [UIColor blackColor];
    [self.spinner sizeToFit];
    
    
    NSURL *url = [[NSURL alloc] initWithString:self.selectedURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:requestObj];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.spinner];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.spinner removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
