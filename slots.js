var i = 0;
var q = 0;
var loop_count = 2;
var finalResult = "🌴💰🎰 | ";
var Slot_Sprites = [];
var firstResult = [];
counter = 0;
var Sprites = {
    'dakyngRaid': 35, 
    'dakyngFreakout': 30, 
    'dakyngTekila': 12,
    'dakyngAlien': 14,
    'dakyngCrown': 15 ,
    '🍒':35
};
var pattern = '\"points\":[0-9][0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?\,';
var final = url.match(pattern);
var pts = final[0].substring(
    final[0].lastIndexOf(":") + 1, 
    final[0].lastIndexOf(",")
);

if (pts < wager ) {
    IsNotAllowed = "Why'd you come to a casino without money? " + user + " tried gambling more points than they have Kappa";
    IsNotAllowed;
}
else{



    Object.keys(Sprites).forEach(key => {
        for (var i = 0; i < Sprites[key]; i++) {
        Slot_Sprites.push(key);
            }
        });

    function shuffle(array) {
        var currentIndex = array.length,  randomIndex;
        while (0 !== currentIndex) {
        
            randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex--;
        
            [array[currentIndex], array[randomIndex]] = [
            array[randomIndex], array[currentIndex]];
        }
        return array;
    }

    while(i < 3){
        var randomInt = Math.floor(Math.random() * Slot_Sprites.length);
        var SlotChoice = Slot_Sprites[randomInt];
        firstResult.push(SlotChoice);
        if (i < 2) {
            finalResult += SlotChoice + " | ";        
        }
        if (i === 2) {
            finalResult += SlotChoice + " | 🎰💰🌴";
        }
        while(q < loop_count){
            shuffle(Slot_Sprites);
            q+=1;
        }q = 0;
        i++;
    }
    i=0;
    q=0;

    for (let index = 0; index < firstResult.length; index++) {
        element = firstResult[index];
        if (element === "🍒") {
            counter += 1;        
        }   
    }

    if(counter === 3){
        myResult = "You're so drunk that you spilled tekila on the machine and broke it. Security had to kick you out...";
        myResult;
    }

    else if (firstResult[0] === firstResult[1] && firstResult[0] === firstResult[2] && firstResult[0] !== "🍒"){
        switch (firstResult[0]) {
            case "dakyngAlien":
                result = Math.floor(wager * 2);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngCrown":
                result = Math.floor(wager * 5);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngFreakout":
                result = Math.floor(wager * 1.5);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngRaid":
                result = Math.floor(wager * 1.25);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngTekila":
                result = Math.floor(wager * 1.75);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
				myResult;
                break;

            default:
                break;
        }
    }
	
    else if(firstResult[2] === "🍒" && firstResult[0] === firstResult[1]){
        switch (firstResult[0]) {
            case "dakyngAlien":
                result = Math.floor(wager * 1.5);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngCrown":
                result = Math.floor(wager * 2.5);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngFreakout":
                result = Math.floor(wager * 1.15);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngRaid":
                result = Math.floor(wager * 1.05);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngTekila":
                result = Math.floor(wager * 1.25);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!"; 
				myResult;            
                break;

            default:
                break;
        }
    }
	
    else if(firstResult[1] === "🍒" && firstResult[0] === firstResult[2]){
        switch (firstResult[0]) {
            case "dakyngAlien":
                result = Math.floor(wager * 1.5);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngCrown":
                result = Math.floor(wager * 2.5);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngFreakout":
                result = Math.floor(wager * 1.15);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngRaid":
                result = Math.floor(wager * 1.05);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;
            case "dakyngTekila":
                result = Math.floor(wager * 1.25);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;            
                break;

            default:
                break;
        }
    }
	
    else if(firstResult[0] === "🍒" && firstResult[1] === firstResult[2]){
        switch (firstResult[1]) {
            case "dakyngAlien":
                result = Math.floor(wager * 1.5);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";   
				myResult;            
                
                break;
            case "dakyngCrown":
                result = Math.floor(wager * 2.5);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";  
				myResult;      
                
                break;
            case "dakyngFreakout":
                result = Math.floor(wager * 1.15);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;      
                
                break;
            case "dakyngRaid":
                result = Math.floor(wager * 1.05);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;      
                
                break;
            case "dakyngTekila":
                result = Math.floor(wager * 1.25);
                myResult = "!addpoints " + user + " " + wager + " ---- " + finalResult + " --- " + user + " has won " + result + " tekilas!!!";
                myResult;
        
                
                break;
            default:
                break;
        }
    }
	
    else if(firstResult[0] !== firstResult[1] && firstResult[0] !== firstResult[2]){
        myresult = "!addpoints " + user + " " + (wager * -1) + " --- " + finalResult + " --- " + user + " lost " + wager + " tekilas lol dont be a sore loser.";
        myresult;
    }
	
    else if(firstResult[2] !== firstResult[0] && firstResult[1] !== firstResult[0]){
        myresult = "!addpoints " + user + " " + (wager * -1) + " --- " + finalResult + " --- " + user + " lost " + wager + " tekilas lol dont be a sore loser.";
        myresult;
    }
	
    else{
        myresult = "!addpoints " + user + " " + (wager * -1) + " --- " + finalResult + " --- " + user + " lost " + wager + " tekilas lol dont be a sore loser.";
        myresult;
    }
}