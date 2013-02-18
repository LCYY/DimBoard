//
//  EditNumberViewController.h
//  DimBoard
//
//  Created by conicacui on 18/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditNumberViewController : UIViewController{
    NSString* m_name;
    double m_value;
    NSString* m_unit;
}

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UITextField *EditInput;
@property (weak, nonatomic) IBOutlet UILabel *UnitLabel;
@property (weak, nonatomic) IBOutlet UISlider *SlidBar;

- (id)initWithName:(NSString *)name Value:(double)value Unit:(NSString *)unit;

@end
