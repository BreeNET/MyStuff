darts1 = ['spectator Kappa',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
darts2 = ['spectator Kappa',2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40];
darts3 = ['spectator Kappa',3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,60];
darts4 = ['spectator Kappa',25,'bullseye!'];

		
        if (chance >= 600){
        
            result = darts1[Math.floor((Math.random() * darts1.length - 1) + 1)];
            result;
        }
           
         else if (chance >= 300 && chance < 600){
            result = darts2[Math.floor((Math.random() * darts2.length - 1) + 1)];
            result;
        }
            
        else if (chance > 50 && chance <= 300){
		    result = darts3[Math.floor((Math.random() * darts3.length - 1) + 1)];
			result;
        } 
		
		
        else if (chance <= 50){
            result = darts4[Math.floor((Math.random() * darts4.length - 1) + 1)];
			if(result === darts4[2]){
				var items = {
						'1x Ashes Kappa': 100, 
						'1x Ring of Wealth(4)': 45, 
						'1x Fury': 44,
						'1x ZGS': 9,
						'1x AGS': 1,
						'1x Bond': 1,
						
					};
				var weightedList = [];

				Object.keys(items).forEach(key => {
				for (var i = 0; i < items[key]; i++) {
				   weightedList.push(key);
					}
				});

				var randomInt = Math.floor(Math.random() * weightedList.length);
				var itemchoice = weightedList[randomInt];
				win = result + " " + userwinner + " unlocks their winner's chest and recieves.... 🔑🎁 " + itemchoice + " @dakyngttv @breebreebran dakyngCrown dakyngCrown dakyngCrown ";
				win;
            }
            else{
                result;
			}
        }