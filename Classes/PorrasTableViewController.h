//
//  PorrasTableViewController.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PorraNewFormController.h"
#import "PorraCD.h"

@interface PorrasTableViewController : UIViewController <PorraNewFormControllerDelegate,
														NSFetchedResultsControllerDelegate,
														UITableViewDelegate, 
														UITableViewDataSource> {
	IBOutlet UITableView *porrasTable;
	IBOutlet UISegmentedControl *selTable;
	
	NSArray *arrayEquipos;
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}


-(IBAction) abrirNuevaPorra:(id)sender;
-(IBAction) cambiaSegmento:(id)sender;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) IBOutlet UITableView *porrasTable;
@property (nonatomic, retain) IBOutlet UISegmentedControl *selTable;

@property (nonatomic, retain) IBOutlet NSArray *arrayEquipos;

@end
