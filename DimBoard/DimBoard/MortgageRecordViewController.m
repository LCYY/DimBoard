//
//  MortgageRecordViewController.m
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "MortgageRecordViewController.h"

@interface MortgageRecordViewController ()

@end

@implementation MortgageRecordViewController

@synthesize m_controllerList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization      
        
        NSMutableArray * array = [[NSMutableArray alloc] init];
        self.m_controllerList = array;
        
        RecordDetailViewController *controller_1 = [[RecordDetailViewController alloc] init];
        RecordDetailViewController *controller_2 = [[RecordDetailViewController alloc] init];
        [self.m_controllerList addObject:controller_1];
        [self.m_controllerList addObject:controller_2];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setM_controllerList:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark-
#pragma mark UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    UITableViewController *controller = [m_controllerList objectAtIndex:row];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark UITableViewDataSource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MortgageRecordCell = @"MortgageRecordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MortgageRecordCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MortgageRecordCell];
    }
    NSUInteger row = [indexPath row];
    UITableViewController *controller = [m_controllerList objectAtIndex:row];
    cell.textLabel.text = controller.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return m_controllerList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"test";
}

@end
