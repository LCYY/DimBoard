//
//  PieChartCellViewController.m
//  DimBoard
//
//  Created by conicacui on 22/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "PieChartCellViewController.h"

@interface PieChartCellViewController ()

@end

@implementation PieChartCellViewController
@synthesize PieChartSlice_output;
@synthesize PieChart;
@synthesize m_slices,m_slicesDesp;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithSlices:(NSArray *)slices Descriptions:(NSArray *)desps Colors:(NSArray*)colors{
    self = [super init];
    if(self){
        m_slices = [slices copy];
        m_slicesDesp = [desps copy];
        if(colors == nil)
            m_sliceColors = [NSArray arrayWithObjects:
                             [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                             [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                             [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                             [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                             [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showPieChar];
}

- (void)viewDidUnload
{
    [self setPieChart:nil];
    [self setM_slices:nil];
    [self setM_slicesDesp:nil];
    [self setPieChartSlice_output:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)showPieChar{
    //set piechart
    [PieChart setDelegate:self];
    [PieChart setDataSource:self];
    [PieChart setShowPercentage:YES];
    [PieChart setShowLabel:YES];
    [PieChart setLabelColor:[UIColor blackColor]];
    [PieChart setLabelFont:[UIFont systemFontOfSize:13.0]];
    [PieChart setPieRadius:100];
    [PieChart setPieBackgroundColor:[UIColor redColor]];
    
//    [PieChartSlice_output setText:[m_slicesDesp objectAtIndex:[m_slices count]]];
//    [PieChartSlice_output setTextAlignment:UITextAlignmentCenter];
    
    [PieChart reloadData];
}

-(void)reloadData{
    [PieChart reloadData];
}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return 4;
    //return m_slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    //CGFloat value = [[m_slices objectAtIndex:index] doubleValue];
    return 0.25;
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    //UIColor* color =  [m_sliceColors objectAtIndex:(index % m_sliceColors.count)];
    return nil;
}
@end