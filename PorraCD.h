//
//  PorraCD.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 05/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class PersonaCD;

@interface PorraCD :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * importe;
@property (nonatomic, retain) NSNumber * abierta;
@property (nonatomic, retain) NSString * escudoLocal;
@property (nonatomic, retain) NSString * local;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * visitante;
@property (nonatomic, retain) NSString * escudoVisitante;
@property (nonatomic, retain) NSString * resultado;
@property (nonatomic, retain) NSSet* participantes;

@end


@interface PorraCD (CoreDataGeneratedAccessors)
- (void)addParticipantesObject:(PersonaCD *)value;
- (void)removeParticipantesObject:(PersonaCD *)value;
- (void)addParticipantes:(NSSet *)value;
- (void)removeParticipantes:(NSSet *)value;

@end

