    //
//  PorrasTableViewController.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PorrasTableViewController.h"
#import "PorraCustomCell.h"

#import "PorrasDetailViewController.h"

@interface PorrasTableViewController ()
- (void)configuraCelda:(PorraCustomCell *)celda atIndexPath:(NSIndexPath *)indexPath;
- (void)saveContext;
@end

@implementation PorrasTableViewController
@synthesize porrasTable;
@synthesize selTable;
@synthesize arrayEquipos;
@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	self.navigationItem.title = @"Lista de Porras";
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(abrirNuevaPorra:)]autorelease];

	[NSFetchedResultsController deleteCacheWithName:nil];
}
	
-(IBAction) abrirNuevaPorra:(id)sender {
	
	PorraNewFormController *controlador = [[PorraNewFormController alloc]initWithNibName:@"PorraNewFormController" bundle:nil];
	
	controlador.delegate = self;
	//controlador.fetchedResultsController = self.fetchedResultsController;
	
	controlador.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
	//controlador.datos = arr;
	
	[self presentModalViewController:controlador animated: YES];
	
	[controlador release];
	
}

-(void) saveFormData:(struct DatosPorra) formData {
	
	//NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
	NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
	
	
	PorraCD *porra_coreData = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.managedObjectContext];
	
	porra_coreData.local = formData.local;
	porra_coreData.visitante = formData.visitante;
	porra_coreData.escudoLocal = formData.escudoLocal;
	porra_coreData.escudoVisitante = formData.escudoVisitante;
	porra_coreData.importe = [NSNumber numberWithFloat:formData.importe];
	porra_coreData.abierta = [NSNumber numberWithBool:TRUE];
	porra_coreData.timeStamp = [NSDate date];
	
	[self saveContext];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
    // Prevent new objects being added when in editing mode.
    [super setEditing:(BOOL)editing animated:(BOOL)animated];
	[self.porrasTable setEditing:editing animated:animated];
    self.navigationItem.rightBarButtonItem.enabled = !editing;
}

- (void)configuraCelda:(PorraCustomCell *)celda atIndexPath:(NSIndexPath *)indexPath {
    
    PorraCD *porraCD = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];
	
	celda.escudoEquipoUno.image = [UIImage imageNamed:porraCD.escudoLocal];
	celda.escudoEquipoDos.image = [UIImage imageNamed:porraCD.escudoVisitante];
	if (porraCD.resultado != nil)
		celda.lblResultado.text = porraCD.resultado;
	else celda.lblResultado.text = @" - ";
	NSLog(@"porraCD.importe %f", [porraCD.importe floatValue]);
	celda.lblApuesta.text = [NSString stringWithFormat:@"Apuesta %.0f €",[porraCD.importe floatValue]];
}

- (void)saveContext {
    
    NSError *error = nil;
	
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}   

-(IBAction) cambiaSegmento:(id)sender {
	
	[self saveContext];
	
	NSPredicate *predicate;
	switch (self.selTable.selectedSegmentIndex){
		case 0:
			[self.navigationItem.rightBarButtonItem setEnabled:TRUE];
			//Mostramos las Porras Abiertas (cuyo resultado es nil)
			predicate = [NSPredicate predicateWithFormat:@"resultado == nil"];
			break;
		case 1:
			[self.navigationItem.rightBarButtonItem setEnabled:FALSE];
			//Mostramos las Porras Cerradas (cuyo resultado es != nil)
			predicate = [NSPredicate predicateWithFormat:@"resultado != nil"];
			break;
		default:
			break;
	}
	[[self.fetchedResultsController fetchRequest] setPredicate:predicate];
	[NSFetchedResultsController deleteCacheWithName:@"Root"];
	
	NSError * error = nil;
	[self.fetchedResultsController performFetch:&error];
	if (error) {
		// report error
		NSLog(@"Catastrófico!");
	}	
	[self.porrasTable reloadData];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
   return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	PorraCustomCell *customCell;
	
	if (cell == nil) {
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		NSArray *listaDeObjetos = [[NSBundle mainBundle] loadNibNamed:@"PorraCustomCell" owner:self options:nil];
		for (id obj in listaDeObjetos){
			if([obj isKindOfClass:[PorraCustomCell class]]) {
				customCell = obj;
			
				[self configuraCelda:customCell atIndexPath:indexPath];

				cell = customCell;
				break;
			}
		}
	}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    return UITableViewCellEditingStyleDelete; 
} 


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
	 if (editingStyle == UITableViewCellEditingStyleDelete) {
		 // Delete the managed object for the given index path
		 NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
		 [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
		 
		 // Save the context.
		 NSError *error = nil;
		 if (![context save:&error]) {
			 //Replace this implementation with code to handle the error appropriately.
			 
			 // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 
			 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			 abort();
		 }
	 }
 }


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */



 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return NO;
 }
 


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
	PorrasDetailViewController *detailViewController = [[PorrasDetailViewController alloc] initWithNibName:@"PorrasDetailViewController" bundle:nil];
	// ...
	// Pass the selected object to the new view controller.
	detailViewController.porra = [self.fetchedResultsController objectAtIndexPath:indexPath];
	//detailViewController.delegate = self;
	detailViewController.managedObjectContext = self.managedObjectContext;
	[self.navigationController pushViewController:detailViewController animated:YES];
	[detailViewController release];
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController_ != nil) {
        return fetchedResultsController_;
    }
    
    /*
     Set up the fetched results controller.
	 */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PorraCD" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
	//Predicate
	switch (self.selTable.selectedSegmentIndex){
		case 0:
			//Mostramos las Porras Abiertas (cuyo resultado es nil)
			fetchRequest.predicate = [NSPredicate predicateWithFormat:@"resultado == nil"];
			break;
		case 1:
			//Mostramos las Porras Cerradas (cuyo resultado es != nil)
			fetchRequest.predicate = [NSPredicate predicateWithFormat:@"resultado != nil"];
			break;
		default:
			break;
	}
	//end of predicate
	
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
																								managedObjectContext:self.managedObjectContext
																								  sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController_;
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.porrasTable beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.porrasTable insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.porrasTable deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.porrasTable;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeUpdate:
		{
			//[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            PorraCustomCell * celda = (PorraCustomCell*)[tableView cellForRowAtIndexPath:indexPath];
			[self configuraCelda:celda atIndexPath:indexPath];
			break;
		}
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.porrasTable endUpdates];
}


#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[managedObjectContext_ release];
	[fetchedResultsController_ release];

	[porrasTable release];
	[selTable release];
    [super dealloc];
}


@end
