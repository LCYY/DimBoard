//
//  InputCell.m
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "InputCell.h"

@implementation InputCell
@synthesize m_cellController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Name:(NSString *)name Value:(NSString *)value{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Custom initialization
        m_cellController = [[InputCellViewController alloc] initWithName:name Value:value];
        [self.contentView addSubview:m_cellController.view];
    }
    return self;
}

- (void) setName:(NSString *)name Value:(NSString *)value{
    if(m_cellController){
        [m_cellController setName:name Value:value];
    }
}

-(void)setCellControllerDelegate:(id<UpdateRecordItemProtocol>)delegate{
    if(m_cellController)
        [m_cellController setM_delegate:delegate];
}

-(NSString *)getValue{
    if(m_cellController){
        return [m_cellController getValue];
    }
    return @"";
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    if(editing){
        
    }else{
        
    }
    
    [UIView commitAnimations];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    return;
}

@end
