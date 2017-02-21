//
//  PorrasDetailViewController.m
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PorrasDetailViewController.h"
#import "PorraDetailCustomCell.h"
#import "PorraDetail2CustomCell.h"


#import "PersonaCD.h"


@implementation PorrasDetailViewController

@synthesize managedObjectContext=managedObjectContext_;
@synthesize porra;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Añadir Apuesta" style: UIBarButtonItemStyleBordered target:self action:@selector(nuevoParticipante)];

	//Solo se permite añadir participantes / editar si la porra está abierta
	if(porra.resultado == nil)
	{
		[self.navigationItem.rightBarButtonItem setEnabled:TRUE];
	}
	else {
		[self.navigationItem.rightBarButtonItem setEnabled:FALSE];
	}

}

- (IBAction) nuevoParticipante {
	
	ParticipanteViewController *controlador = [[ParticipanteViewController alloc]initWithNibName:@"ParticipanteViewController" bundle:nil];
	
	controlador.delegate = self;
	
	//controlador.fetchedResultsController = self.fetchedResultsController;
	
	controlador.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	
	//controlador.datos = arr;
	
	[self presentModalViewController:controlador animated: YES];
	controlador.equipoLocal.text = porra.local;
	controlador.equipoVisitante.text = porra.visitante;
	controlador.personaEditada = nil;
	[controlador release];
	
}

-(void) saveParticipanteNombre:(NSString*)nombre Resultado:(NSString*)res {
	PersonaCD *pers = [NSEntityDescription insertNewObjectForEntityForName:@"PersonaCD" inManagedObjectContext:self.managedObjectContext];
	pers.nombre = nombre;
	pers.resultado = res;
	[porra addParticipantesObject:pers];
	[self.tableView reloadData];
}

-(void) eliminarParticipante:(PersonaCD*)persona
{
	[porra removeParticipantesObject:persona];
}

-(void) ModalDidEnd:(UIViewController *) controlador {
	[self.tableView reloadData];
	[controlador dismissModalViewControllerAnimated:YES];
	if(porra.resultado == nil)
	{
		[self.navigationItem.rightBarButtonItem setEnabled:TRUE];
	}
	else {
		[self.navigationItem.rightBarButtonItem setEnabled:FALSE];
	} 
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
	NSString *encabezado=nil;
	
    switch (section) {
        case 0:
            encabezado = @"";
            break;
        case 1:
            encabezado = @"Detalles";
            break;
        case 2:
		{
			if ([[porra participantes] count] > 0) {
				encabezado = @"Apuestas";
			}else {
				encabezado = @"";
			}
            break;
		}
    }
    return encabezado;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0 && indexPath.row == 0)
	{
		return 121.0;
	}
	else if (indexPath.section == 1)
	{
		return 44.0;
	}
	return 44.0;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellAccessoryType tipo;
	if(self.porra.resultado == nil)
	{
		
		if (indexPath.section == 0) {
			tipo = UITableViewCellAccessoryDisclosureIndicator;
		}else if (indexPath.section == 1) {
			tipo = UITableViewCellAccessoryNone;
		}
		else if (indexPath.section == 2) {
			tipo = UITableViewCellAccessoryDisclosureIndicator;
		}
	}
	else { 
		tipo = UITableViewCellAccessoryNone;
		self.tableView.allowsSelection = FALSE;
	}
	return tipo;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	int numOfRows;
	if (section == 0){
		//sección 'marcador'
		numOfRows = 1;
	}else if (section == 1){
		//Timestamp y Apuesta
		numOfRows = 3;
	}else if (section == 2){
		//participantes
		numOfRows = [[porra participantes] count];
	}
	
	return numOfRows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
	static NSString *CellIdentifier = @"Cell";
 
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	
	if (cell == nil) {
		
		switch ([indexPath section]) {
			case 0:
			{
				if([indexPath row]==0) {
					//Sección 0, Fila 0. Esta celda tiene 'marcador' del partido, con los escudos y nombres de los equipos.
					
					//cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
					//cell.textLabel.text = pr.nombre;
					NSArray *listaDeObjetos = [[NSBundle mainBundle] loadNibNamed:@"PorraDetailCustomCell" owner:self options:nil];
					for (id obj in listaDeObjetos){
						if([obj isKindOfClass:[PorraDetailCustomCell class]]) {
							PorraDetailCustomCell *celda = obj;
							
							celda.lblEquipoUno.text = porra.local;
							celda.lblEquipoDos.text = porra.visitante;
							celda.escudoEquipoUno.image = [UIImage imageNamed:porra.escudoLocal];
							celda.escudoEquipoDos.image = [UIImage imageNamed:porra.escudoVisitante];
							if (porra.resultado != nil)
								celda.lblResultado.text = porra.resultado;
							else celda.lblResultado.text = @" - ";
							
							cell = celda;
						}
					}
				}
				break;
			}
			case 1:
			{
				//Sección 1, Tiene filas con los atributos de la Porra.
				//Utilizamos una celda personalizada "CeldaDetalleProducto" para cada celda.
				NSArray *listaDeObjetos = [[NSBundle mainBundle] loadNibNamed:@"PorraDetail2CustomCell" owner:self options:nil];
				for (id obj in listaDeObjetos){
					if([obj isKindOfClass:[PorraDetail2CustomCell class]]) {
						PorraDetail2CustomCell *celda = obj;
						switch ([indexPath row]) {
							case 0:
								//Sección 1, Fila 0 : Fecha
								celda.lblAtributo.text = @"Fecha Alta";
								celda.lblValor.text = [[porra.timeStamp description] substringToIndex:19];
								break;
							case 1:
								//Sección 1, Fila 1: Apuesta
								celda.lblAtributo.text = @"Imp.Apuesta";
								celda.lblValor.text = [NSString stringWithFormat:@"%.0f €",[porra.importe floatValue]];
								break;
							case 2:
								//Sección 1, Fila 2: Participantes
								celda.lblAtributo.text = @"Núm.Apuestas";
								celda.lblValor.text = [NSString stringWithFormat:@"%d",[porra.participantes count]];
								break;
							default:
								break;
						}
						cell = celda;
					}
				}
				
				break;
			}
			
			case 2:
			{
				NSArray *listaDeObjetos = [[NSBundle mainBundle] loadNibNamed:@"PorraDetail2CustomCell" owner:self options:nil];
				for (id obj in listaDeObjetos){
					if([obj isKindOfClass:[PorraDetail2CustomCell class]]) {
						PorraDetail2CustomCell *celda = obj;
						
						PersonaCD *persona = [[[porra participantes] allObjects] objectAtIndex:indexPath.row];
						celda.lblAtributo.text =  persona.nombre;
						celda.lblValor.text = persona.resultado;
						
						if(porra.resultado != nil)
						{
							if([persona.resultado isEqualToString:porra.resultado])
							{
								celda.lblAtributo.textColor = [UIColor greenColor];
								celda.lblValor.textColor = [UIColor greenColor];
							}
							else {
								celda.lblAtributo.textColor = [UIColor redColor];
								celda.lblValor.textColor = [UIColor redColor];
							}
						}
						cell = celda;
					}
				}
			}
	
			default:
				break;
				
		}//endof switch ([indexPath section])
		
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
  	
	if (indexPath.section == 0) {
		if ([[porra participantes] count] > 0)
		{
			ResultadoPartidoViewController *controlador = [[ResultadoPartidoViewController alloc]initWithNibName:@"ResultadoPartidoViewController" bundle:nil];
			
			controlador.delegate = self;
			
			controlador.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
			
			controlador.porra = self.porra;
			
			[self presentModalViewController:controlador animated: YES];
			
			[controlador release];
		}
		else {
			UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"No se puede cerrar la Porra!" message:@"La porra debe tener al menos 1 participante" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
			[myAlertView show];
			[myAlertView release];
		}

	}
	else if (indexPath.section == 2) {
		ParticipanteViewController *controlador = [[ParticipanteViewController alloc]initWithNibName:@"ParticipanteViewController" bundle:nil];
		
		controlador.delegate = self;
		
		controlador.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		
		PersonaCD *persona = [[[porra participantes] allObjects] objectAtIndex:indexPath.row];
		controlador.personaEditada = persona;
		
		[self presentModalViewController:controlador animated: YES];
		
		controlador.equipoLocal.text = porra.local;
		controlador.equipoVisitante.text = porra.visitante;
		
		[controlador release];
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
	[managedObjectContext_ release];
    [super dealloc];
}


@end

