//
//  DimBoardTabBarViewController.m
//  DimBoard
//
//  Created by Lin Yangyang on 13-3-4.
//  Copyright (c) 2013年 LCYY. All rights reserved.
//

#import "DimBoardTabBarViewController.h"

@interface DimBoardTabBarViewController ()

@end

@implementation DimBoardTabBarViewController
@synthesize m_calViewController, m_recordViewController, m_settingViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    m_recordViewController = [[MortgageRecordViewController alloc] init];
    UINavigationController* recordNavController = [[UINavigationController alloc] initWithRootViewController:m_recordViewController];
    
    m_calViewController = [[MortgageCalViewController alloc] init];
    [m_calViewController setRecordViewController:m_recordViewController];
    UINavigationController* calNavController = [[UINavigationController alloc] initWithRootViewController:m_calViewController];
    
    m_settingViewController = [[SettingViewController alloc] init];
    UINavigationController* settingNavController = [[UINavigationController alloc] initWithRootViewController:m_settingViewController];
    
    
    UITabBarItem* item1 = [[UITabBarItem alloc] initWithTitle:DimBoardLocalizedString(@"Calculator") image:[UIImage imageNamed:@"cal.png"] tag:1];
    UITabBarItem* item2 = [[UITabBarItem alloc] initWithTitle:DimBoardLocalizedString(@"MortgageRecord") image:[UIImage imageNamed:@"record.png"] tag:2];
    UITabBarItem* item3 = [[UITabBarItem alloc] initWithTitle:DimBoardLocalizedString(@"Setting") image:[UIImage imageNamed:@"setting.png"] tag:3];
    
    [calNavController setTabBarItem:item1];
    [recordNavController setTabBarItem:item2];
    [settingNavController setTabBarItem:item3];
    
    [self setViewControllers:[NSArray arrayWithObjects:calNavController,recordNavController, settingNavController,nil]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeLanuage:) name:NOTI_CHANGELANGUAGE object:nil];
}

-(void)onChangeLanuage:(NSNotification*)noti{
    [[[self.viewControllers objectAtIndex:0] tabBarItem] setTitle:DimBoardLocalizedString(@"Calculator")];
    [[[self.viewControllers objectAtIndex:1] tabBarItem] setTitle:DimBoardLocalizedString(@"MortgageRecord")];
    [[[self.viewControllers objectAtIndex:2] tabBarItem] setTitle:DimBoardLocalizedString(@"Setting")];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    UIInterfaceOrientation orientation =  self.interfaceOrientation;
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SCREENROTATION object:[NSString stringWithFormat:@"%d",orientation]];
    return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_SCREENROTATION object:[NSString stringWithFormat:@"%d",toInterfaceOrientation]];
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
