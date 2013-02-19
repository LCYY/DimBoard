//
//  AddRecordViewController.m
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "AddRecordViewController.h"

@interface AddRecordViewController ()

@end

@implementation AddRecordViewController
@synthesize m_section0,m_section1,m_section2,m_section3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_section0 = @"貸款名稱"; //input cell
        m_section1 = @"貸款銀行"; //input cell
        NSArray *value1 = [[NSArray alloc] initWithObjects:@"物業樓價",@"%",nil];
        NSArray *value2 = [[NSArray alloc] initWithObjects:@"按揭成數",@"%",nil];
        NSArray *value3 = [[NSArray alloc] initWithObjects:@"還款年期",@"年",nil];
        NSArray *value4 = [[NSArray alloc] initWithObjects:@"按揭利率",@"%",nil];
        m_section2 = [[NSArray alloc] initWithObjects:value1,value2,value3,value4,nil];
        
        m_section3 = @"貸款日期"; //input cell
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style{
    //set style as UITableViewStyleGrouped
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)hideKeyboard:(id)sender{
    [self.view endEditing:YES];
}

-(void)onCancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    if(section == 1){
        BankPickerViewController* rootController = [[BankPickerViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
        
        navController.navigationBar.topItem.title = m_section1;
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        UIBarButtonItem *cacelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemDone target:self action:@selector(onCancel:)];
        navController.navigationBar.topItem.leftBarButtonItem = cacelButton;
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonSystemItemDone target:rootController action:@selector(onSave:)];
        navController.navigationBar.topItem.rightBarButtonItem = saveButton;
        
        [navController setWantsFullScreenLayout:YES];
        [navController.view setAutoresizesSubviews:NO];
        navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentModalViewController:navController animated:YES];
    }else if(section == 3){
        DatePickerViewController* rootController = [[DatePickerViewController alloc] init];       
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootController];
        
        navController.navigationBar.topItem.title = m_section3;
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        UIBarButtonItem *cacelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemDone target:self action:@selector(onCancel:)];
        navController.navigationBar.topItem.leftBarButtonItem = cacelButton;
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"存儲" style:UIBarButtonSystemItemDone target:rootController action:@selector(onSave:)];
        navController.navigationBar.topItem.rightBarButtonItem = saveButton;
        
        [navController setWantsFullScreenLayout:YES];
        [navController.view setAutoresizesSubviews:NO];
        navController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        navController.visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentModalViewController:navController animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 2)
        return 75;
    else
        return 45;
}

#pragma mark UITableViewDataSource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *AddNormalRecordCell = @"AddNormalRecordCell";
    static NSString *AddInputRecordCell = @"AddInputRecordCell";
    static NSString *AddSliderRecordCell = @"AddSliderRecordCell";
    
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    UITableViewCell *cell = nil;
    
    if(section == 0){ // input cell
        cell = [tableView dequeueReusableCellWithIdentifier:AddInputRecordCell];
    }else if(section == 1 || section == 3){ // normal cell
        cell = [tableView dequeueReusableCellWithIdentifier:AddNormalRecordCell];
    }else if(section == 2){ //slider cell
        cell = [tableView dequeueReusableCellWithIdentifier:AddSliderRecordCell];
    }
    
    if(cell == nil){
        if(section == 0){
            cell = [[InputCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AddInputRecordCell Name:m_section0 Value:@""];
        }else if(section == 1){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AddNormalRecordCell];
            cell.textLabel.text = m_section1;
            cell.detailTextLabel.text = @"";
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        else if(section == 2){
            NSString *name = [[m_section2 objectAtIndex:row] objectAtIndex:0];
            NSString *unit = [[m_section2 objectAtIndex:row] objectAtIndex:1];
            cell = [[SliderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AddSliderRecordCell Name:name Value:@"" Unit:unit];
        }else if(section == 3){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:AddNormalRecordCell];
            cell.textLabel.text = m_section3;
            cell.detailTextLabel.text = @"";
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
    }else{
        if(section == 0){
            [((InputCell *)cell) setName:m_section0 Value:@""];
        }else if(section == 1){
            cell.textLabel.text = m_section1;
            cell.detailTextLabel.text = @"";
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        else if(section == 2){
            NSString *name = [[m_section2 objectAtIndex:row] objectAtIndex:0];
            NSString *unit = [[m_section2 objectAtIndex:row] objectAtIndex:1];
            [((SliderCell *)cell) setName:name Value:@"" Unit:unit];
        }else if(section == 3){
            cell.textLabel.text = m_section3;
            cell.detailTextLabel.text = @"";
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
    }
    [cell setEditing:YES animated:NO];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return [m_section2 count];
    }else if(section == 3){
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
@end
