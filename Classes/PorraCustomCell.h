//
//  PorraCustomCell.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PorraCustomCell : UITableViewCell {

	UILabel *lblApuesta;
	UILabel *lblResultado;
	UIImageView *escudoEquipoUno;
	UIImageView *escudoEquipoDos;
}

@property (nonatomic,retain) IBOutlet UILabel *lblApuesta;
@property (nonatomic,retain) IBOutlet UIImageView *escudoEquipoUno;
@property (nonatomic,retain) IBOutlet UIImageView *escudoEquipoDos;
@property (nonatomic,retain) IBOutlet UILabel *lblResultado;

@end
