//
//  ReachMeDirectionsViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 23/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeDirectionsViewController.h"
#import "Utils.h"
#import "ReachMeDirectionsPageContentViewController.h"
@interface ReachMeDirectionsViewController ()

@end

@implementation ReachMeDirectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *directionTitle = @"via bommanahalli";
    NSString *direction = @"kodichikanahalli";
    
    NSArray * arr = [[NSArray alloc] initWithObjects:directionTitle, direction,nil];
    
    self.directions = [[NSMutableArray alloc] init];
    [self.directions addObject:arr];
    
    directionTitle = @"via BG Road";
    direction = @"behind vijaya bank colony";
    
    NSArray * arrr = [[NSArray alloc] initWithObjects:directionTitle, direction,nil];
    [self.directions addObject:arrr];
    
    
    NSLog(@"%@", [self.directions objectAtIndex:1]);
    UIStoryboard *storyboard = [Utils getStoryBoard];
    
    self.pageViewController = [storyboard instantiateViewControllerWithIdentifier:@"PageViewVC"];
    
    self.pageViewController.dataSource = self;
    
    ReachMeDirectionsPageContentViewController *  startingViewController = [self viewControllerAtIndex:0];
    
    NSArray *vcs = @[startingViewController];
    
    [self.pageViewController setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [[[self tabBarController] tabBar] bounds].size.height);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    [self setNavigationBarBtns];
}

- (void)setNavigationBarBtns {
    //    UIViewController* vc = self.appDelegate.window.rootViewController;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editDirection)];
    self.parentViewController.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareAddress)];
    self.parentViewController.navigationItem.rightBarButtonItem = rightBtn;
}

- (void) editDirection{
    NSLog(@"edit direction");
}

- (void)shareAddress{
    NSLog(@"share direction");    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ReachMeDirectionsPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.directions count] == 0) || (index >= [self.directions count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    ReachMeDirectionsPageContentViewController *vc = [[Utils getStoryBoard] instantiateViewControllerWithIdentifier:@"DirectionsContentHolder"];
    vc.titleText = [[self.directions objectAtIndex:index] objectAtIndex:0];
    vc.directionText = [[self.directions objectAtIndex:index] objectAtIndex:1];
    
    vc.pageIndex = index;
    
    return vc;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma PageViewController 
- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((ReachMeDirectionsPageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.directions count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((ReachMeDirectionsPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.directions count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}
@end
