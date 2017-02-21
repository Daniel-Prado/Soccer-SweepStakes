//
//  PersonaCD.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 05/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class PorraCD;

@interface PersonaCD :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * resultado;
@property (nonatomic, retain) PorraCD * porra;

@end



