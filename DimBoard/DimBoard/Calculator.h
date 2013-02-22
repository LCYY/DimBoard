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

}

@property (retain, nonatomic) NSMutableArray* m_principals;
@property (retain, nonatomic) MortgageInput* m_input;
@property (retain, nonatomic) MortgageOutput* m_output;

-(void)setInput:(MortgageInput*)input;
-(MortgageOutput*)getOutput;
-(void)getMonthlyPrincipals:(NSMutableArray*)arry;


@end
