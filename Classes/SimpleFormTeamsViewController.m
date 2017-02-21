    //
//  SimpleFormTeamsViewController.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 03/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleFormTeamsViewController.h"
#import "PorrasAppDelegate.h"

@implementation SimpleFormTeamsViewController

@synthesize delegate, arrayEquipos, equipoYaSeleccionado, visitante;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	PorrasAppDelegate *appDelegate = (PorrasAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.arrayEquipos = appDelegate.arrayEquipos;
	//txt.delegate = self;
}

-(IBAction)cancelForm {
	
	[self dismissModalViewControllerAnimated:NO];
}



- (void)viewWillAppear:(BOOL)animated {
	// Make the keyboard appear when the form shows.
	[super viewWillAppear:animated];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
	return [self.arrayEquipos count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

    }
    
    // Configure the cell...
	int fila	=	[indexPath row];
    NSDictionary *diccionario = [self.arrayEquipos objectAtIndex:fila];
	
	NSString *nombre = [diccionario objectForKey:@"NombreEquipo"];
	
	cell.textLabel.text = nombre;
	
	return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    int fila	=	[indexPath row];
    NSDictionary *diccionario = [self.arrayEquipos objectAtIndex:fila];
	NSString *nombre = [diccionario objectForKey:@"NombreEquipo"];
	NSString *escudo = [diccionario objectForKey:@"Escudo"];
	int i = (int)self.visitante;
	[self.delegate saveFormEquipo:nombre Escudo:escudo Indice:i];
	
	[self dismissModalViewControllerAnimated:NO];
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
	[arrayEquipos release];
    [super dealloc];
}


@end
