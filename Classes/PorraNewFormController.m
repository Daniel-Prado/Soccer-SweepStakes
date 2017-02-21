//
//  PorraNewFormController.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 02/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PorraNewFormController.h"
#import "PorraDetail2CustomCell.h"




@implementation PorraNewFormController
@synthesize porraNewTable;
@synthesize delegate;
//@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
}

- (IBAction)cancelPorra {
	[self dismissModalViewControllerAnimated:YES];
	
}

- (IBAction)savePorra {
	if([apuesta.local isEqualToString:@""] || [apuesta.visitante isEqualToString:@""] || apuesta.importe == 0) {
		UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"¡Atención!" message:@"Revise los datos introducidos" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
		[myAlertView show];
		[myAlertView release];
	}
	else if ([apuesta.local isEqualToString:apuesta.visitante])
	{
		UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"¡Esto no es un partido de entrenamiento!" message:@"Escoge dos equipos diferentes" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
		[myAlertView show];
		[myAlertView release];
	}
	else {
		[self.delegate saveFormData:apuesta];
		[self dismissModalViewControllerAnimated:YES];
	}
}


- (void)saveFormData:(NSString *) formData{
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	
	apuesta.importe = [[formatter numberFromString:formData] floatValue];
	
	[formatter release];

}

-(void) saveFormEquipo:(NSString*)nombre Escudo:(NSString*)escudo Indice:(int)i {
	
	//tempString = formData;
	if (i == 0)
	{
		apuesta.local = nombre;
		apuesta.escudoLocal = escudo;
	}else {
		apuesta.visitante = nombre;
		apuesta.escudoVisitante = escudo;
	}

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.porraNewTable reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    int numOfRows;
	if (section == 0)
		numOfRows = 2;
	else if (section == 1)
		numOfRows = 1;
	else numOfRows = 1;
	
	return numOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	PorraDetail2CustomCell *celda;
	if (cell == nil) {
		
		switch ([indexPath section]) {
			case 0:
			{
				NSArray *listaDeObjetos = [[NSBundle mainBundle] loadNibNamed:@"PorraDetail2CustomCell" owner:self options:nil];
				for (id obj in listaDeObjetos){
					if([obj isKindOfClass:[PorraDetail2CustomCell class]]) {
						celda = obj;
					}
				}
				if([indexPath row]==0) {
					celda.lblAtributo.text = @"Local";
					celda.lblValor.text = apuesta.local; //@""; //rellenar con valor devuelto por la vista modal
				}else if([indexPath row]==1) {
					celda.lblAtributo.text = @"Visitante";
					celda.lblValor.text = apuesta.visitante; //rellenar con valor devuelto por la vista modal
				}
				cell = celda;
				
				break;
			}
			case 1:
			{
				//Sección 1, Tiene filas con los atributos de la Porra.
				//Utilizamos una celda personalizada "CeldaDetalleProducto" para cada celda.
				NSArray *listaDeObjetos = [[NSBundle mainBundle] loadNibNamed:@"PorraDetail2CustomCell" owner:self options:nil];
				for (id obj in listaDeObjetos){
					if([obj isKindOfClass:[PorraDetail2CustomCell class]]) {
						celda = obj;
						switch ([indexPath row]) {
							case 0:
								//Sección 1, Fila 0 : Fecha
								celda.lblAtributo.text = @"Imp.Apuesta(€)";
								celda.lblValor.text = [NSString stringWithFormat:@"%2.0f €", apuesta.importe];
								break;
							/*
							case 1:
								//Sección 1, Fila 1: Apuesta
								celda.lblAtributo.text = @"Imp.Apuesta";
								celda.lblValor.text = @"";
								break;
							case 2:
								//Sección 1, Fila 2: Participantes
								celda.lblAtributo.text = @"Participantes";
								celda.lblValor.text = @"";
								break;
							 */
							default:
								break;
						}
						cell = celda;
					}
				}
				
				break;
			}
			default:
				break;
				
		}//endof switch ([indexPath section])
		
	}
	
    // Configure the cell...
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

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
	if (indexPath.section == 0)
	{
		SimpleFormTeamsViewController *simpleFormTeamsViewController = [[SimpleFormTeamsViewController alloc]initWithNibName:@"SimpleFormTeamsViewController" bundle:nil];
		
		if([indexPath row] == 1)
			simpleFormTeamsViewController.visitante = TRUE;
		else {
			simpleFormTeamsViewController.visitante = FALSE;
		}

		
		simpleFormTeamsViewController.delegate = self;
		
		simpleFormTeamsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		[self presentModalViewController:simpleFormTeamsViewController animated: NO];
		
		[simpleFormTeamsViewController release];
	}
	else if (indexPath.section == 1)
	{
		//por vista modal
		
		SimpleFormViewController *simpleFormViewController = [[SimpleFormViewController alloc]initWithNibName:@"SimpleFormViewController" bundle:nil];
		
		simpleFormViewController.delegate = self;
		
		simpleFormViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
		//simpleFormViewController.datos = arr;
		
		[self presentModalViewController:simpleFormViewController animated: NO];
		
		[simpleFormViewController release];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
//	[managedObjectContext_ release];
//	[fetchedResultsController_ release];
	[porraNewTable release];
    [super dealloc];
}


@end

