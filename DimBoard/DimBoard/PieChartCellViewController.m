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
@synthesize ColorLabel_1,ColorLabel_2,ColorLabel_3,ColorLabel_4,ColorLabel_5;
@synthesize m_colorLabels;

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
        m_selectedSliceIndex = -1;
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
    
    m_colorLabels = [NSArray arrayWithObjects:ColorLabel_1,ColorLabel_2,ColorLabel_3,ColorLabel_4,ColorLabel_5,nil];
    
    for(int i = 0; i < [m_colorLabels count]; i++){
        UIButton* label = [m_colorLabels objectAtIndex:i];
        [label setBackgroundColor:[m_sliceColors objectAtIndex:i]];
        [label setHidden:YES];
        [label.titleLabel setAdjustsFontSizeToFitWidth:YES];
    }
    for(int i = 0; i < [m_slices count]; i++){
        UIButton* label = [m_colorLabels objectAtIndex:i];
        NSString* text = [[[m_slicesDesp objectAtIndex:i] componentsSeparatedByString:@":"] objectAtIndex:0];
        [label.titleLabel setText:text];
        [label setTitle:text forState:UIControlStateNormal];
        [label setTitle:text forState:UIControlStateReserved];
        [label setTitle:text forState:UIControlStateSelected];
        [label setTitle:text forState:UIControlStateHighlighted];
        
        [label setUserInteractionEnabled:YES];
        UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onColorLabelTouched:)];
        [label addGestureRecognizer:recognizer];
    }
    
    [self showPieChar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onViewRotation:) name:NOTI_SCREENROTATION object:nil];
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
    [self setColorLabel_1:nil];
    [self setColorLabel_2:nil];
    [self setColorLabel_3:nil];
    [self setColorLabel_4:nil];
    [self setColorLabel_5:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

-(BOOL)shouldAutorotate{
    
    return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)onViewRotation:(NSNotification*) noti{
    NSString* orientation = noti.object;
    NSInteger widthchange = 160;
    CGRect screen = [[UIScreen mainScreen] bounds];
    if(screen.size.height == 480){
    }else if(screen.size.height == 568){
        widthchange = widthchange + (568 - 480);
    }
    
    if(UIInterfaceOrientationIsLandscape([orientation integerValue])){
        CGRect frame = self.view.frame;
        frame.size.width = screen.size.height;
        [self.view setFrame:frame];
        
        frame = ExtendButton.frame;
        frame.origin.x = 263 + widthchange;
        [ExtendButton setFrame:frame];
        
        NSLog(@"extend button frame = %f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

        
        frame = PieChart.frame;
        frame.origin.x = -2 + widthchange/2 - 50;
        [PieChart setFrame:frame];
        
                
        for(int i = 0; i < [m_slices count]; i++){
            UILabel* label = [m_colorLabels objectAtIndex:i];
            frame = label.frame;
            frame.origin.x = 227 + widthchange/2;
            [label setFrame:frame];
             [label setUserInteractionEnabled:YES];
        }
    }else{
        CGRect frame = self.view.frame;
        frame.size.width = 320;
        [self.view setFrame:frame];
        
        frame = ExtendButton.frame;
        frame.origin.x = 263;
        [ExtendButton setFrame:frame];
        
        NSLog(@"extend button frame = %f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

        
        frame = PieChart.frame;
        frame.origin.x = -2;
        [PieChart setFrame:frame];
        
        
        for(int i = 0; i < [m_slices count]; i++){
            UILabel* label = [m_colorLabels objectAtIndex:i];
            frame = label.frame;
            frame.origin.x = 227;
            [label setFrame:frame];
             [label setUserInteractionEnabled:YES];
        }
    }
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
        [self showColorLabels];
    }else{
        m_height = 45;
        [PieChart setHidden:YES];
        [PieChartSlice_output setHidden:YES];
        [ExtendButton setBackgroundImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];
        [ExtendButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self hideColorLabels];
    }
    [m_delegate extendPieChartCell:m_extend atIndexPath:m_indexPath];
}

-(CGFloat)getHeight{
    return m_height;
}

-(void)hideColorLabels{
    for(int i = 0; i < [m_slices count]; i++){
        [[m_colorLabels objectAtIndex:i] setHidden:YES];
    }
}

-(void)showColorLabels{
    for(int i = 0; i < [m_slices count]; i++){
        [[m_colorLabels objectAtIndex:i] setHidden:NO];
    }
}

-(void)onColorLabelTouched:(id)sender{
    UITapGestureRecognizer* recognizer = (UITapGestureRecognizer*)sender;
    UIButton* button = (UIButton*)recognizer.view;

    for(int i = 0; i < [m_slices count]; i++){
        if(button == [m_colorLabels objectAtIndex:i]){
            if(m_selectedSliceIndex == i){
                [PieChart setSliceDeselectedAtIndex:i];
                [self pieChart:PieChart didDeselectSliceAtIndex:i];
            }else{
                [PieChart setSliceSelectedAtIndex:i];
                [self pieChart:PieChart didSelectSliceAtIndex:i];
            }
        }else{
            [PieChart setSliceDeselectedAtIndex:i];
            [self pieChart:PieChart didDeselectSliceAtIndex:i];
        }
    }
    
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
    return [m_sliceColors objectAtIndex:index];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    //NSLog(@"did select slice at index %d",index);
    for(int i = 0; i < [m_slices count]; i++){
        UIButton* button = (UIButton*)[m_colorLabels objectAtIndex:i];
        [button.layer setBorderColor:[UIColor clearColor].CGColor];
    }
    UIButton* button = (UIButton*)[m_colorLabels objectAtIndex:index];
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
    [button.layer setBorderWidth:3];
    
    m_selectedSliceIndex = index;
    [PieChartSlice_output setText:[m_slicesDesp objectAtIndex:index]];
}

-(void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index{
    //NSLog(@"did De-select slice at index %d",index);
    if(m_selectedSliceIndex == index){
        m_selectedSliceIndex = -1;
    }
    if(m_selectedSliceIndex == -1){
        UIButton* button = (UIButton*)[m_colorLabels objectAtIndex:index];
        [button.layer setBorderColor:[UIColor clearColor].CGColor];
        [PieChartSlice_output setText:[m_slicesDesp objectAtIndex:[m_slices count]]];
    }
}
@end
