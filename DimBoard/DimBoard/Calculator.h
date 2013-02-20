//
//  Calculator.h
//  DimBoard
//
//  Created by conicacui on 4/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MortgageDataType.h"

@interface Calculator : NSObject{

    MortgageInput* m_input;
    MortgageOutput* m_output;

    NSMutableArray* m_principals;
}

@property (retain, nonatomic) NSMutableArray* m_principals;

-(void)setInput:(MortgageInput*)input;
-(void)getOutput:(MortgageOutput*)output;
-(void)getMonthlyPrincipals:(NSMutableArray*)arry;


@end
