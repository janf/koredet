/** @flow */


export function parse_transaction_text(text) {
    var tokenArr = text.split(" ");

    console.log("tokenArr: " + JSON.stringify(tokenArr));

    var parsed_text = {};

    var item_name = ""

    var parse_result;
    var arrayLength = tokenArr.length;
	for (var i = 0; i < arrayLength; i++) {
		switch(tokenArr[i].toLowerCase()) {
			case "antall":
				parsed_text["qty"] =  tokenArr[i+1];
				i++;
				console.log("Antall funnet");
				break;

			case "fra", "from":	
				parsed_text["from"] =  tokenArr[i+1];
				i++;
				break;

			case "til", "to":	
				parsed_text["to"] =  tokenArr[i+1];
				i++;
				break;


			default:

				if(i === 0)
				item_name = tokenArr[i];
			else					
				item_name = item_name.concat(" ", tokenArr[i]);
		}
	}

	parsed_text["item_name"] = item_name;

    return parsed_text;
}