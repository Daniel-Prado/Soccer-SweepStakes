//
//  PorrasNavController.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 31/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PorrasTableViewController.h"

@interface PorrasNavController : UINavigationController  {

	IBOutlet PorrasTableViewController *porrasTableViewController;
@private
    //NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) IBOutlet PorrasTableViewController *porrasTableViewController;



//@property (nonatomic, retain) IBOutlet SegmentsController * segmentsController;

@end
