//
//  PostDetailViewController.m
//  RedditReader
//
//  Created by Everett Gilmore on 2/3/16.
//  Copyright © 2016 Everett Gilmore. All rights reserved.
//

#import "PostDetailViewController.h"
#import <SpinKit/RTSpinKitView.h>

@import WebKit;

@interface PostDetailViewController () <WKNavigationDelegate, WKUIDelegate>
@property (nonatomic) WKWebView *webView;
@property (nonatomic) RTSpinKitView *spinner;
@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc]
                     initWithFrame:self.view.frame configuration:theConfiguration];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    self.spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleFadingCircleAlt];
    self.spinner.frame = CGRectMake(self.view.frame.size.width/2 - 15, self.view.frame.size.height/2 - self.navigationController.navigationBar.frame.size.height, 30, 30);
    self.spinner.spinnerSize = 30.0;
    self.spinner.color = [UIColor blackColor];
    [self.spinner sizeToFit];
    
    
    NSURL *url = [[NSURL alloc] initWithString:self.selectedURL];
    NSLog(@"%@", url);
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:requestObj];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.spinner];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
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
