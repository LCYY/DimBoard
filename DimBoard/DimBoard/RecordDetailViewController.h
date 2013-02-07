//
//  RecordDetailViewController.h
//  DimBoard
//
//  Created by conicacui on 7/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) NSArray *m_items;
@end
