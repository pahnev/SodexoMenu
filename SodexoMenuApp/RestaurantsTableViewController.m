//
//  RestaurantsTableViewController.m
//
//
//  Created by Kirill Pahnev on 1.9.2014.
//
//

#import "RestaurantsTableViewController.h"

@interface RestaurantsTableViewController () <UIViewControllerRestoration>

@end

@implementation RestaurantsTableViewController {
    NSArray *espoo;
    NSArray *espooUrls;
    NSArray *finnair;
    NSArray *finnairUrls;
    NSArray *forssa;
    NSArray *forssaUrls;
    NSArray *helsinki;
    NSArray *helsinkiUrls;
    NSArray *hyvinkaa;
    NSArray *hyvinkaaUrls;
    NSArray *ikaalinen;
    NSArray *ikaalinenUrls;
    NSArray *ilmajoki;
    NSArray *ilmajokiUrls;
    NSArray *jyvaskyla;
    NSArray *jyvaskylaUrls;
    NSArray *kaarina;
    NSArray *kaarinaUrls;
    NSArray *kankaanpaa;
    NSArray *kankaanpaaUrls;
    NSArray *kempele;
    NSArray *kempeleUrls;
    NSArray *kokkola;
    NSArray *kokkolaUrls;
    NSArray *kuortane;
    NSArray *kuortaneUrls;
    NSArray *kurikka;
    NSArray *kurikkaUrls;
    NSArray *lappeenranta;
    NSArray *lappeenrantaUrls;
    NSArray *nokia;
    NSArray *nokiaUrls;
    NSArray *oulu;
    NSArray *ouluUrls;
    NSArray *pori;
    NSArray *poriUrls;
    NSArray *porvoo;
    NSArray *porvooUrls;
    NSArray *rauma;
    NSArray *raumaUrls;
    NSArray *salo;
    NSArray *saloUrls;
    NSArray *seinajoki;
    NSArray *seinajokiUrls;
    NSArray *tampere;
    NSArray *tampereUrls;
    NSArray *turku;
    NSArray *turkuUrls;
    NSArray *tuusula;
    NSArray *tuusulaUrls;
    NSArray *vantaa;
    NSArray *vantaaUrls;
    NSArray *varkaus;
    NSArray *varkausUrls;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];

	self.restorationIdentifier = @"RestaurantsTableView";
	self.restorationClass = [self class];

	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([_cityName isEqualToString:@"Espoo"]) {
        return [espoo count];
    } else if ([_cityName isEqualToString:@"Helsinki-Vantaan lentoasema"]) {
        return [finnair count];
    } else if ([_cityName isEqualToString:@"Forssa"]) {
        return [forssa count];
    } else if ([_cityName isEqualToString:@"Helsinki"]) {
        return [helsinki count];
    } else if ([_cityName isEqualToString:@"Hyvinkää"]) {
        return [hyvinkaa count];
    } else if ([_cityName isEqualToString:@"Ikaalinen"]) {
        return [ikaalinen count];
    } else if ([_cityName isEqualToString:@"Ilmajoki"]) {
        return [ilmajoki count];
    } else if ([_cityName isEqualToString:@"Jyväskylä"]) {
        return [jyvaskyla count];
    } else if ([_cityName isEqualToString:@"Kaarina"]) {
        return [kaarina count];
    } else if ([_cityName isEqualToString:@"Kankaanpää"]) {
        return [kankaanpaa count];
    } else if ([_cityName isEqualToString:@"Kempele"]) {
        return [kempele count];
    } else if ([_cityName isEqualToString:@"Kokkola"]) {
        return [kokkola count];
    } else if ([_cityName isEqualToString:@"Kuortane"]) {
        return [kuortane count];
    } else if ([_cityName isEqualToString:@"Kurikka"]) {
        return [kurikka count];
    } else if ([_cityName isEqualToString:@"Lappeenranta"]) {
        return [lappeenranta count];
    } else if ([_cityName isEqualToString:@"Nokia"]) {
        return [nokia count];
    } else if ([_cityName isEqualToString:@"Oulu"]) {
        return [oulu count];
    } else if ([_cityName isEqualToString:@"Pori"]) {
        return [pori count];
    } else if ([_cityName isEqualToString:@"Porvoo"]) {
        return [porvoo count];
    } else if ([_cityName isEqualToString:@"Rauma"]) {
        return [rauma count];
    } else if ([_cityName isEqualToString:@"Salo"]) {
        return [salo count];
    } else if ([_cityName isEqualToString:@"Seinäjoki"]) {
        return [seinajoki count];
    } else if ([_cityName isEqualToString:@"Tampere"]) {
        return [tampere count];
    } else if ([_cityName isEqualToString:@"Turku"]) {
        return [turku count];
    } else if ([_cityName isEqualToString:@"Tuusula"]) {
        return [tuusula count];
    } else if ([_cityName isEqualToString:@"Vantaa"]) {
        return [vantaa count];
    } else if ([_cityName isEqualToString:@"Varkaus"]) {
        return [varkaus count];
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }


    // Configure the cell...
    if ([_cityName isEqualToString:@"Espoo"]) {
        cell.textLabel.text = [espoo objectAtIndex:indexPath.row];
		
    } else if ([_cityName isEqualToString:@"Helsinki"]) {
        cell.textLabel.text = [helsinki objectAtIndex:indexPath.row];
		
    } else if ([_cityName isEqualToString:@"Forssa"]) {
        cell.textLabel.text = [forssa objectAtIndex:indexPath.row];
		
    } else if ([_cityName isEqualToString:@"Helsinki-Vantaan lentoasema"]) {
        cell.textLabel.text = [finnair objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Hyvinkää"]) {
        cell.textLabel.text = [hyvinkaa objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Ikaalinen"]) {
        cell.textLabel.text = [ikaalinen objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Ilmajoki"]) {
        cell.textLabel.text = [ilmajoki objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Jyväskylä"]) {
        cell.textLabel.text = [jyvaskyla objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Kaarina"]) {
        cell.textLabel.text = [kaarina objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Kankaanpää"]) {
        cell.textLabel.text = [kankaanpaa objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Kempele"]) {
        cell.textLabel.text = [kempele objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Kokkola"]) {
        cell.textLabel.text = [kokkola objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Kuortane"]) {
        cell.textLabel.text = [kuortane objectAtIndex:indexPath.row];
	
	} else if ([_cityName isEqualToString:@"Kurikka"]) {
		cell.textLabel.text = [kurikka objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Lappeenranta"]) {
        cell.textLabel.text = [lappeenranta objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Nokia"]) {
        cell.textLabel.text = [nokia objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Oulu"]) {
        cell.textLabel.text = [oulu objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Pori"]) {
        cell.textLabel.text = [pori objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Porvoo"]) {
        cell.textLabel.text = [porvoo objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Rauma"]) {
        cell.textLabel.text = [rauma objectAtIndex:indexPath.row];
		
	} else if ([_cityName isEqualToString:@"Salo"]) {
        cell.textLabel.text = [salo objectAtIndex:indexPath.row];
		
	} else if ([_cityName isEqualToString:@"Seinäjoki"]) {
        cell.textLabel.text = [seinajoki objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Tampere"]) {
        cell.textLabel.text = [tampere objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Turku"]) {
        cell.textLabel.text = [turku objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Tuusula"]) {
        cell.textLabel.text = [tuusula objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Vantaa"]) {
        cell.textLabel.text = [vantaa objectAtIndex:indexPath.row];
    
	} else if ([_cityName isEqualToString:@"Varkaus"]) {
        cell.textLabel.text = [varkaus objectAtIndex:indexPath.row];
    }

    return cell;
}

#pragma mark - Helpers

- (void)loadData
{
    self.cityArray = self.json[@"cities"];

    NSArray *espooArray = [self.json[@"cities"] valueForKey:@"Espoo"];
    NSArray *finnairArray = [self.json[@"cities"] valueForKey:@"Helsinki-Vantaan lentoasema"];
    NSArray *forssaArray = [self.json[@"cities"] valueForKey:@"Forssa"];
    NSArray *helsinkiArray = [self.json[@"cities"] valueForKey:@"Helsinki"];
    NSArray *hyvinkaaArray = [self.json[@"cities"] valueForKey:@"Hyvinkää"];
    NSArray *ikaalinenArray = [self.json[@"cities"] valueForKey:@"Ikaalinen"];
    NSArray *ilmajokiArray = [self.json[@"cities"] valueForKey:@"Ilmajoki"];
    NSArray *jyvaskylaArray = [self.json[@"cities"] valueForKey:@"Jyväskylä"];
    NSArray *kaarinaArray = [self.json[@"cities"] valueForKey:@"Kaarina"];
    NSArray *kankaanpaaArray = [self.json[@"cities"] valueForKey:@"Kankaanpää"];
    NSArray *kempeleArray = [self.json[@"cities"] valueForKey:@"Kempele"];
    NSArray *kokkolaArray = [self.json[@"cities"] valueForKey:@"Kokkola"];
    NSArray *kuortaneArray = [self.json[@"cities"] valueForKey:@"Kuortane"];
    NSArray *kurikkaArray = [self.json[@"cities"] valueForKey:@"Kurikka"];
    NSArray *lappeenrantaArray = [self.json[@"cities"] valueForKey:@"Lappeenranta"];
    NSArray *nokiaArray = [self.json[@"cities"] valueForKey:@"Nokia"];
    NSArray *ouluArray = [self.json[@"cities"] valueForKey:@"Oulu"];
    NSArray *poriArray = [self.json[@"cities"] valueForKey:@"Pori"];
    NSArray *porvooArray = [self.json[@"cities"] valueForKey:@"Porvoo"];
    NSArray *raumaArray = [self.json[@"cities"] valueForKey:@"Rauma"];
    NSArray *saloArray = [self.json[@"cities"] valueForKey:@"Salo"];
    NSArray *seinajokiArray = [self.json[@"cities"] valueForKey:@"Seinäjoki"];
    NSArray *tampereArray = [self.json[@"cities"] valueForKey:@"Tampere"];
    NSArray *turkuArray = [self.json[@"cities"] valueForKey:@"Turku"];
    NSArray *tuusulaArray = [self.json[@"cities"] valueForKey:@"Tuusula"];
    NSArray *vantaaArray = [self.json[@"cities"] valueForKey:@"Vantaa"];
    NSArray *varkausArray = [self.json[@"cities"] valueForKey:@"Varkaus"];

    espoo = [espooArray valueForKey:@"title"];
    espooUrls = [espooArray valueForKey:@"url"];
	
    finnair = [finnairArray valueForKey:@"title"];
	finnairUrls = [finnairArray valueForKey:@"url"];
    
	forssa = [forssaArray valueForKey:@"title"];
	forssaUrls = [forssaArray valueForKey:@"url"];

    helsinki = [helsinkiArray valueForKey:@"title"];
    helsinkiUrls = [helsinkiArray valueForKey:@"url"];

    hyvinkaa = [hyvinkaaArray valueForKey:@"title"];
    hyvinkaaUrls = [hyvinkaaArray valueForKey:@"url"];

    ikaalinen = [ikaalinenArray valueForKey:@"title"];
    ikaalinenUrls = [ikaalinenArray valueForKey:@"url"];

    ilmajoki = [ilmajokiArray valueForKey:@"title"];
    ilmajokiUrls = [ilmajokiArray valueForKey:@"url"];

    jyvaskyla = [jyvaskylaArray valueForKey:@"title"];
    jyvaskylaUrls = [jyvaskylaArray valueForKey:@"url"];

    kaarina = [kaarinaArray valueForKey:@"title"];
	kaarinaUrls = [kaarinaArray valueForKey:@"url"];
    
	kankaanpaa = [kankaanpaaArray valueForKey:@"title"];
	kankaanpaaUrls = [kankaanpaaArray valueForKey:@"url"];

    kempele = [kempeleArray valueForKey:@"title"];
    kempeleUrls = [kempeleArray valueForKey:@"url"];

    kokkola = [kokkolaArray valueForKey:@"title"];
    kokkolaUrls = [kokkolaArray valueForKey:@"url"];

    kuortane = [kuortaneArray valueForKey:@"title"];
    kuortaneUrls = [kuortaneArray valueForKey:@"url"];

    kurikka = [kurikkaArray valueForKey:@"title"];
    kurikkaUrls = [kurikkaArray valueForKey:@"url"];

    lappeenranta = [lappeenrantaArray valueForKey:@"title"];
    lappeenrantaUrls = [lappeenrantaArray valueForKey:@"url"];

    nokia = [nokiaArray valueForKey:@"title"];
    nokiaUrls = [nokiaArray valueForKey:@"url"];

    oulu = [ouluArray valueForKey:@"title"];
    ouluUrls = [ouluArray valueForKey:@"url"];

    pori = [poriArray valueForKey:@"title"];
    poriUrls = [poriArray valueForKey:@"url"];

    porvoo = [porvooArray valueForKey:@"title"];
    porvooUrls = [porvooArray valueForKey:@"url"];

    rauma = [raumaArray valueForKey:@"title"];
    raumaUrls = [raumaArray valueForKey:@"url"];

    salo = [saloArray valueForKey:@"title"];
    saloUrls = [saloArray valueForKey:@"url"];

    seinajoki = [seinajokiArray valueForKey:@"title"];
    seinajokiUrls = [seinajokiArray valueForKey:@"url"];

    tampere = [tampereArray valueForKey:@"title"];
    tampereUrls = [tampereArray valueForKey:@"url"];

    turku = [turkuArray valueForKey:@"title"];
    turkuUrls = [turkuArray valueForKey:@"url"];

    tuusula = [tuusulaArray valueForKey:@"title"];
    tuusulaUrls = [tuusulaArray valueForKey:@"url"];

    vantaa = [vantaaArray valueForKey:@"title"];
    vantaaUrls = [vantaaArray valueForKey:@"url"];

    varkaus = [varkausArray valueForKey:@"title"];
    varkausUrls = [varkausArray valueForKey:@"url"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMenu"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TableViewController *destinationViewController = segue.destinationViewController;
		if ([_cityName isEqualToString:@"Espoo"]) {
			destinationViewController.url = [espooUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Helsinki"]) {
			destinationViewController.url = [helsinkiUrls objectAtIndex:indexPath.row];
			
		}else if ([_cityName isEqualToString:@"Forssa"]) {
			destinationViewController.url = [forssaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Helsinki-Vantaan lentoasema"]) {
			destinationViewController.url = [finnairUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Hyvinkää"]) {
			destinationViewController.url = [hyvinkaaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Ikaalinen"]) {
			destinationViewController.url = [ikaalinenUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Ilmajoki"]) {
			destinationViewController.url = [ilmajokiUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Jyväskylä"]) {
			destinationViewController.url = [jyvaskylaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Kaarina"]) {
			destinationViewController.url = [kaarinaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Kankaanpää"]) {
			destinationViewController.url = [kankaanpaaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Kempele"]) {
			destinationViewController.url = [kempeleUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Kokkola"]) {
			destinationViewController.url = [kokkolaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Kuortane"]) {
			destinationViewController.url = [kuortaneUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Kurikka"]) {
			destinationViewController.url = [kurikkaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Lappeenranta"]) {
			destinationViewController.url = [lappeenrantaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Nokia"]) {
			destinationViewController.url = [nokiaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Oulu"]) {
			destinationViewController.url = [ouluUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Pori"]) {
			destinationViewController.url = [poriUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Porvoo"]) {
			destinationViewController.url = [porvooUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Rauma"]) {
			destinationViewController.url = [raumaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Salo"]) {
			destinationViewController.url = [saloUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Seinäjoki"]) {
			destinationViewController.url = [seinajokiUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Tampere"]) {
			destinationViewController.url = [tampereUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Turku"]) {
			destinationViewController.url = [turkuUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Tuusula"]) {
			destinationViewController.url = [tuusulaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Vantaa"]) {
			destinationViewController.url = [vantaaUrls objectAtIndex:indexPath.row];
			
		} else if ([_cityName isEqualToString:@"Varkaus"]) {
			destinationViewController.url = [varkausUrls objectAtIndex:indexPath.row];
		}
		
		
		
      destinationViewController.title = destinationViewController.restaurantName;
    }
}
+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    UIViewController * myViewController =
	[[TableViewController alloc]
	 initWithNibName:@"RestaurantsTableViewControllerViewController"
	 bundle:nil];
	
    return myViewController;
}
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];
}
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];
}

@end
