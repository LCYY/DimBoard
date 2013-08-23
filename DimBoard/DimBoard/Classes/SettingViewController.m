//
//  SettingViewController.m
//  DimBoard
//
//  Created by conicacui on 15/3/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize m_settingIO;
@synthesize m_langPickerViewController;
@synthesize m_sections;
@synthesize m_delegate;
@synthesize m_tableView,m_adBannerView;

-(id)init{
    self = [super init];
    if(self){
        m_settingIO = [[SettingIO alloc] initWithLoadSettings];
        [self changeLanguage];
        m_langPickerViewController = [[LangPickerViewController alloc] initWithLangId:m_settingIO.m_settings.langId];
        m_langPickerViewController.m_delegate = self;
        m_sections = [[NSMutableArray alloc] init];
        [self setSectionsWithSettings];
    }
    return self;
}

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
    // Do any additional setup after loading the view from its nib.
    
    [m_tableView setDelegate:self];
    [m_tableView setDataSource:self];
    [m_adBannerView setDelegate:self];
    
    [self rotateToOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = DimBoardLocalizedString(@"Setting");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSectionsWithSettings{
    [m_sections removeAllObjects];
    NSArray* sectionkeys0 = [[NSArray alloc] initWithObjects:
                             DimBoardLocalizedString(@"Language"),
                             nil];
    NSArray* sectionValues0 = [[NSArray alloc] initWithObjects:
                               [[[LangTypes alloc] init] getLangNameById:m_settingIO.m_settings.langId],
                               nil];
    NSArray* sectionPair0 = [[NSMutableArray alloc] initWithObjects:sectionkeys0, sectionValues0, nil];
    
    [m_sections addObject:sectionPair0];
}

-(void)changeLanguage{
    LocalizationSetLanguage(m_settingIO.m_settings.langId);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHANGELANGUAGE object:nil];
}

-(void)onViewRotation:(NSNotification*) noti{
    NSString* orientation = noti.object;
    [self rotateToOrientation:[orientation integerValue]];
}

-(void)rotateToOrientation:(UIInterfaceOrientation) orientation{
    CGRect frame = m_tableView.frame;
    CGRect bannerframe = m_adBannerView.frame;
    CGRect layout = self.view.frame;
    if(m_adBannerView.isHidden){
        frame.size.height = layout.size.height;
    }else{
        frame.size.height = layout.size.height - bannerframe.size.height;
    }
    [m_tableView setFrame:frame];
    bannerframe.origin.y = frame.origin.y + frame.size.height;
    bannerframe.origin.x = frame.origin.x;
    [m_adBannerView setFrame:bannerframe];
}

#pragma mark - UITable Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellRecognizer = @"CellRecognizer";
    UITableViewCell* cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:CellRecognizer];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellRecognizer];
    }
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSString* key = [[[m_sections objectAtIndex:section] objectAtIndex:0] objectAtIndex:row];
    NSString* value = [[[m_sections objectAtIndex:section] objectAtIndex:1] objectAtIndex:row];
    
    cell.textLabel.text = key;
    cell.detailTextLabel.text = value;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self.navigationController.view addSubview:m_langPickerViewController.view];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [m_sections count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - UpdateSettingItemDelegate
-(void)updateSettingKey:(NSString *)key withValue:(id)value{
    if([key isEqualToString:KEY_SETTING_LANG]){
        m_settingIO.m_settings.langId = [((NSNumber*)value) integerValue];
        [m_settingIO save];
        [self changeLanguage];
        [self setSectionsWithSettings];
        self.title = DimBoardLocalizedString(@"Setting");
        [m_tableView reloadData];
    }
}
- (void)viewDidUnload {
    [self setM_tableView:nil];
    [self setM_adBannerView:nil];
    [super viewDidUnload];
}

#pragma mark - ADBannerView
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    CGRect frame = m_tableView.frame;
    CGRect bannerframe = m_adBannerView.frame;
    CGRect layout = self.view.frame;
    frame.size.height = layout.size.height - bannerframe.size.height;
    [m_tableView setFrame:frame];
    
    bannerframe.origin.y = frame.origin.y + frame.size.height;
    bannerframe.origin.x = frame.origin.x;
    [m_adBannerView setFrame:bannerframe];
    [m_adBannerView setHidden:false];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    CGRect frame = m_tableView.frame;
    frame.size.height = self.view.frame.size.height;
    [m_tableView setFrame:frame];
    [m_tableView setFrame:frame];
    [m_adBannerView setHidden:true];
}
@end
