//
//  SliderCellViewController.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DimBoardProtocols.h"
#import "DimBoardNotifications.h"

@interface SliderCellViewController : UIViewController<UITextFieldDelegate>
{
    NSString* m_name;
    NSString* m_value;
    NSString* m_unit;
    double m_step;
    double m_currentValue;
    double m_minValue;
    double m_maxValue;
    double m_stepCoeff;
    int m_repeatCnt;
}
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ValueInput;
@property (weak, nonatomic) IBOutlet UILabel *UnitLabel;
@property (weak, nonatomic) IBOutlet UIButton *MinusButton;
@property (weak, nonatomic) IBOutlet UIButton *AddButton;


@property (weak, nonatomic) id<UpdateRecordItemProtocol> m_deletegate;
@property (retain, nonatomic) NSTimer* m_timer;

- (IBAction)onMinusDown:(id)sender;
- (IBAction)onAddDown:(id)sender;
- (id)initWithName:(NSString *)name Value:(NSString*)value Unit:(NSString *)unit;
- (void) setName:(NSString *)name Value:(NSString *)value Unit:(NSString *)unit;
@end
