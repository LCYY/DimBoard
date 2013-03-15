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

-(id)init{
    self = [super init];
    if(self){
        m_settingIO = [[SettingIO alloc] initWithLoadSettings];
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
    self.title = NSLocalizedString(@"Setting", nil);
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITable Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellRecognizer = @"CellRecognizer";
    UITableViewCell* cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:CellRecognizer];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellRecognizer];
    }
    
    NSInteger row = indexPath.row;
    NSString* key = [[m_settingIO.m_settings objectAtIndex:row] objectAtIndex:0];
    NSString* value = [[m_settingIO.m_settings objectAtIndex:row] objectAtIndex:1];
    
    cell.textLabel.text = key;
    cell.detailTextLabel.text = value;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [m_settingIO.m_settings count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
