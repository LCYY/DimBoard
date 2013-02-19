//
//  InputCellViewController.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputCellViewController : UIViewController<UITextFieldDelegate>{
    NSString* m_name;
    NSString* m_value;
    UITapGestureRecognizer *m_gestureRecognizer;
}
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UITextField *ValueInput;

- (id)initWithName:(NSString *)name Value:(NSString*)value;
- (void) setName:(NSString *)name Value:(NSString *)value;
@end
