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
#import "ReachMeEditDirectionViewController.h"
#import "User.h"
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
    
    
    
    UIStoryboard *storyboard = [Utils getStoryBoard];
    
    self.pageViewController = [storyboard instantiateViewControllerWithIdentifier:@"PageViewVC"];
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    ReachMeDirectionsPageContentViewController *  startingViewController = [self viewControllerAtIndex:0];
    
    NSArray *vcs = @[startingViewController];
    
    [self.pageViewController setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [[[self tabBarController] tabBar] bounds].size.height - 200);
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.addNewDirection.frame.origin.y);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.currentPageIndex = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDirection:) name:@"addNewDirection" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDirection:) name:@"editDirection" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setNavigationBarBtns];
}
- (void)setNavigationBarBtns {
    //    UIViewController* vc = self.appDelegate.window.rootViewController;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editDirection)];
    self.parentViewController.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAddress)];
    self.parentViewController.navigationItem.rightBarButtonItem = rightBtn;
}

- (void) editDirection{
    
    [self addEditDirection:YES];
    
//    [UIView animateWithDuration:0.75
//                     animations:^{
//                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                         [self.navigationController pushViewController:vc animated:YES];
//                         [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
//                     }];
//      [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)shareAddress{
    NSLog(@"share direction");
}

- (void)refreshDirectionsList {
    ReachMeDirectionsPageContentViewController *  startingViewController = [self viewControllerAtIndex:0];
    NSArray *vcs = @[startingViewController];
    [self.pageViewController setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}
- (void)addEditDirection:(BOOL)edit{
    ReachMeEditDirectionViewController *vc = [ReachMeEditDirectionViewController getInstance];
    vc.directionTitleText = nil;
    vc.directionText = nil;
    if (edit) {
        vc.mode = EDIT;
        vc.directionTitleText = [[self.directions objectAtIndex:self.currentPageIndex] objectAtIndex:0];
        vc.directionText = [[self.directions objectAtIndex:self.currentPageIndex] objectAtIndex:1];
        vc.navigationItem.title = @"Edit Direction";
    }else {
        vc.mode = ADD;
        vc.navigationItem.title = @"New Direction";
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)addNewDirection:(id)sender{
    [self addEditDirection:NO];
}
- (IBAction)removeDirection:(id)sender{
    [self.directions removeObjectAtIndex:self.currentPageIndex];
    [self refreshDirectionsList];
}

- (void)updateDirection:(NSNotification*)notification {
    NSDictionary * dict = [notification userInfo];
    NSString * label = [dict objectForKey:@"label"];
    NSString * text = [dict objectForKey:@"text"];
    
    NSArray * updatedDirection = [[NSArray alloc] initWithObjects:label, text, nil];
    [self.directions replaceObjectAtIndex:self.currentPageIndex withObject:updatedDirection];
    [self saveDirection];
    [self refreshDirectionsList];
}
- (void)addDirection:(NSNotification*)notification {
    NSDictionary *dict = [notification userInfo];
    NSString * label = [dict objectForKey:@"label"];
    NSString * text = [dict objectForKey:@"text"];
    NSArray *newDirection = [[NSArray alloc] initWithObjects:label,text, nil];
    [self.directions addObject:newDirection];
    [self saveDirection];
    [self refreshDirectionsList];
}

-(void)saveDirection{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:[[User getInstance] userInfo]];
    [dict setObject:self.directions forKey:@"directions"];
    
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

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        self.currentPageIndex = ((ReachMeDirectionsPageContentViewController*)self.pageViewController.viewControllers[0]).pageIndex;
    }
}
@end
