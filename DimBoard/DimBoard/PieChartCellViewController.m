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
@synthesize TitleLabel;
@synthesize PieChartSlice_output;
@synthesize PieChart;
@synthesize ExtendButton;
@synthesize m_slices,m_slicesDesp;
@synthesize m_indexPath;
@synthesize m_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithSlices:(NSArray *)slices Descriptions:(NSArray *)desps Colors:(NSArray*)colors IndexPath:(NSIndexPath *)indexpath{
    self = [super init];
    if(self){
        m_extend = NO;
        m_height = 45;
        m_slices = [slices copy];
        m_slicesDesp = [desps copy];
        m_indexPath = [indexpath copy];
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
    [PieChart setHidden:YES];
    [PieChartSlice_output setHidden:YES];
    [TitleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    [self showPieChar];
}

- (void)viewDidUnload
{
    [self setPieChart:nil];
    [self setM_slices:nil];
    [self setM_slicesDesp:nil];
    [self setPieChartSlice_output:nil];
    [self setExtendButton:nil];
    [self setM_delegate:nil];
    [self setM_indexPath:nil];
    [self setTitleLabel:nil];
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
    
    [PieChartSlice_output setText:[m_slicesDesp objectAtIndex:[m_slices count]]];
    [PieChartSlice_output setTextAlignment:UITextAlignmentCenter];
    
    [PieChart reloadData];
}

-(void)setSlices:(NSArray*)slices Descriptions:(NSArray*)desps Colors:(NSArray*)colors IndexPath:(NSIndexPath *)indexpath{
    m_slices = [slices copy];
    m_slicesDesp = [desps copy];
    m_indexPath = [indexpath copy];
    if(colors == nil)
        m_sliceColors = [NSArray arrayWithObjects:
                         [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                         [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                         [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                         [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                         [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    [PieChartSlice_output setText:[m_slicesDesp objectAtIndex:[m_slices count]]];
    [PieChartSlice_output setTextAlignment:UITextAlignmentCenter];
    [PieChart reloadData];
}

- (IBAction)toggleExtendStatus:(id)sender {
    m_extend = !m_extend;
    if(m_extend){
        m_height = 335;
        [PieChart setHidden:NO];
        [PieChartSlice_output setHidden:NO];
        [ExtendButton setBackgroundImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
        [ExtendButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }else{
        m_height = 45;
        [PieChart setHidden:YES];
        [PieChartSlice_output setHidden:YES];
        [ExtendButton setBackgroundImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
        [ExtendButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    [m_delegate extendPieChartCell:m_extend atIndexPath:m_indexPath];
}

-(CGFloat)getHeight{
    return m_height;
}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return m_slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return[[m_slices objectAtIndex:index] doubleValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [m_sliceColors objectAtIndex:(index % m_sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    //NSLog(@"did select slice at index %d",index);
    m_selectedSliceIndex = index;
    [PieChartSlice_output setText:[m_slicesDesp objectAtIndex:index]];
}

-(void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index{
    //NSLog(@"did De-select slice at index %d",index);
    if(m_selectedSliceIndex == index){
        m_selectedSliceIndex = -1;
    }
    if(m_selectedSliceIndex == -1)
        [PieChartSlice_output setText:[m_slicesDesp objectAtIndex:[m_slices count]]];
}
@end
