//
//  SliderCell.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SliderCellViewController.h"

@interface SliderCell : UITableViewCell{

}
@property (nonatomic, retain) SliderCellViewController *m_cellController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Name:(NSString *)name Value:(NSString *)value Unit:(NSString *)unit;
- (void) setName:(NSString *)name Value:(NSString *)value Unit:(NSString *)unit;

@end
