//
//  SliderCellViewController.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderCellViewController : UIViewController
{
    NSString* m_name;
    NSString* m_value;
    NSString* m_unit;
}
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ValueInput;
@property (weak, nonatomic) IBOutlet UILabel *UnitLabel;
@property (weak, nonatomic) IBOutlet UISlider *SlideBar;

- (id)initWithName:(NSString *)name Value:(NSString*)value Unit:(NSString *)unit;
- (void) setName:(NSString *)name Value:(NSString *)value Unit:(NSString *)unit;
@end
