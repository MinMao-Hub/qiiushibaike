//
//  MapView Controller.m
//  qiushibaikeProject
//
//  Created by  on 14-9-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MapView Controller.h"

@implementation MapView_Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    [self setWebView];
    [self setNavBar];
    //添加左滑手势
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backForwardView:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [webView addGestureRecognizer:rightSwipe];
}
- (void)backForwardView:(UISwipeGestureRecognizer *)swipe
{
    [webView goBack];
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
- (void)setWebView
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreemWidth, kScreemHeight-20-44)];
    [webView setUserInteractionEnabled:YES];
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.directionalLockEnabled = NO;
    NSURL *url = [NSURL URLWithString:@"http://map.baidu.com/mobile/webapp/index/index/foo=bar/vt=map"];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
    
    if ([[webView subviews] count] > 0) {   // hide the shadows 
        for (UIView* shadowView in [[[webView subviews] objectAtIndex:0] subviews]) 
        {     
            [shadowView setHidden:YES];   
        }   // show the content  
        
        [[[[[webView subviews] objectAtIndex:0] subviews] lastObject] setHidden:NO]; 
    } 
    webView.backgroundColor = [UIColor whiteColor];
    webView.autoresizesSubviews = YES;//自动调整大小
    webView.scalesPageToFit = YES; //自动对页面进行缩放以适应屏幕
    
    [self.view addSubview:webView];
    
}
- (void)setNavBar
{
    //添加导航栏
    UIImageView *myNavBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, 64)];
    myNavBar.userInteractionEnabled = YES;
    myNavBar.image = [UIImage imageNamed:@"photos_nav_bg"];
    [self.view addSubview:myNavBar];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 130)/2, 20, 130, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"周边";
    
    titleLabel.font = [UIFont systemFontOfSize:23.f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(2, 27, 30, 30);
    [backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:backButton];
    
}
- (void)backHomeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
