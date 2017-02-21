//
//  PorraNewFormController.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 02/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleFormViewController.h"
#import "SimpleFormTeamsViewController.h"


struct DatosPorra
{
    NSString* local;
    NSString* visitante;
	NSString* escudoLocal;
	NSString* escudoVisitante;
	float importe;
};

@protocol PorraNewFormControllerDelegate;

@interface PorraNewFormController : UIViewController	<SimpleFormViewControllerDelegate,
														SimpleFormTeamsViewControllerDelegate,
														UITableViewDelegate, 
														UITableViewDataSource> {
	
	id <PorraNewFormControllerDelegate> delegate;
	
	IBOutlet UITableView *porraNewTable;

	NSString *tempString;
															
	struct DatosPorra apuesta;
/*
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
*/
}


- (IBAction)cancelPorra;
- (IBAction)savePorra;

@property (nonatomic,retain) id <PorraNewFormControllerDelegate> delegate;
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) IBOutlet UITableView *porraNewTable;


@end


@protocol PorraNewFormControllerDelegate

//-(void) ModalDidEnd:(PorraNewFormController *) controlador;
-(void) saveFormData:(struct DatosPorra) formData;

@end