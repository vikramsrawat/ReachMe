//
//  ReachMeEditDirectionViewController.m
//  ReachMe
//
//  Created by Vikram Singh Rawat on 24/09/14.
//  Copyright (c) 2014 IntruO. All rights reserved.
//

#import "ReachMeEditDirectionViewController.h"
#import "Utils.h"
@interface ReachMeEditDirectionViewController ()

@end

@implementation ReachMeEditDirectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //To make the border look very close to a UITextField
    [_direction.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_direction.layer setBorderWidth:.5];
    
    //The rounded corner part, where you specify your view's corner radius:
    _direction.layer.cornerRadius = 5;
    _direction.clipsToBounds = YES;

    [self setNavigationBarBtns];
}

- (void)viewWillAppear:(BOOL)animated{
    self.directionTitle.text = self.directionTitleText;
    self.direction.text = self.directionText;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(ReachMeEditDirectionViewController*)getInstance {
    static ReachMeEditDirectionViewController* instance = nil;
    if (!instance) {
        instance = [[Utils getStoryBoard] instantiateViewControllerWithIdentifier:@"DirectionEditVC"];
    }
    return instance;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setNavigationBarBtns{
    //    UIViewController* vc = self.appDelegate.window.rootViewController;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveDirection)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)cancelEdit{
    [self removeFromParentViewController];
}

- (void)saveDirection{
    NSString * label = self.directionTitle.text;
    NSString * text = self.direction.text;
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:label forKey:@"label"];
    [dict setObject:text forKey:@"text"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addNewDirection" object:self userInfo:dict];
    [self removeFromParentViewController];
}

- (void)removeFromParentViewController{
//    [UIView animateWithDuration:0.75
//                     animations:^{
//                         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                         [UIView setAnimationTransition:UIViewAnimationTransitio forView:self.navigationController.view cache:NO];
//                     }];
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
