//
//  PorrasDetailViewController.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PorraCD.h"
#import "ParticipanteViewController.h"
#import "ResultadoPartidoViewController.h"


@interface PorrasDetailViewController : UITableViewController <ResultadoPartidoViewControllerDelegate,ParticipanteViewControllerDelegate> {

	PorraCD *porra;
	
@private
        NSManagedObjectContext *managedObjectContext_;
}
	-(IBAction)nuevoParticipante;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) PorraCD *porra;

@end
