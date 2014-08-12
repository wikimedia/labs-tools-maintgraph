var dataSetType = location.pathname.substring(location.pathname.lastIndexOf("/") + 1);

var ITWIKI = "https://it.wikipedia.org/wiki/";

switch (dataSetType) {
    case "lavoro_sporco.html":

		/* Lavoro sporco start */

		var dataSetUrl = "../data/lavoro_sporco.php";

		var hashName = {
			"template": "0",
			"aiutare": "1",
			"categorizzare": "2",
			"controllare": "3",
			"controlcopy": "4",
			"correggere": "5",
			"dividere": "6",
			"enciclopedicita": "7",
			"finzione": "8",
			"localismo": "9",
			"organizzare": "10",
			"orfane": "11",
			"recentismo": "12",
			"fonti": "13",
			"chiarire": "14",
			"note": "15",
			"cn": "16",
			"stub": "17",
			"stubsezione": "18",
			"tradurre": "19",
			"unire": "20",
			"npov": "21",
			"senzauscita": "22",
			"wikificare": "23"
		};
		
		var maybeLink = 1;

		var dict = {
			"Aggiungere template": ITWIKI + "Categoria:Aggiungere_template",
			"Aiutare": ITWIKI + "Categoria:Aiutare",
			"Categorizzare": ITWIKI + "Categoria:Categorizzare",
			"Controllare": ITWIKI + "Categoria:Controllare",
			"ControlCopy": ITWIKI + "Categoria:Controllare_copyright",
			"Correggere": ITWIKI + "Categoria:Correggere",
			"Dividere": ITWIKI + "Categoria:Dividere",
			"Enciclopedicita": ITWIKI + "Categoria:Verificare_enciclopedicit%E0",
			"Finzione": ITWIKI + "Categoria:Finzione_non_contestualizzata",
			"Localismo": ITWIKI + "Categoria:Localismo",
			"Organizzare": ITWIKI + "Categoria:Organizzare",
			"Orfane": ITWIKI + "Categoria:Pagine_orfane",
			"Recentismo": ITWIKI + "Categoria:Recentismo",
			"Senza fonti": ITWIKI + "Categoria:Senza_fonti",
			"Chiarire": ITWIKI + "Categoria:Chiarire",
			"Nessuna nota": ITWIKI + "Categoria:Contestualizzare_fonti",
			"Citazione necessaria": ITWIKI + "Categoria:Informazioni_senza_fonte",
			"Stub": ITWIKI + "Categoria:Stub",
			"Stub sezione": ITWIKI + "Categoria:Stub_sezione",
			"Tradurre": ITWIKI + "Categoria:Tradurre",
			"Unire": ITWIKI + "Categoria:Unire",
			"Voci non neutrali": ITWIKI + "Categoria:Voci_non_neutrali",
			"Voci senza uscita": ITWIKI + "Categoria:Voci_senza_uscita",
			"Wikificare": ITWIKI + "Categoria:Wikificare"
		};
		
		var colors = colors24;
		
		var maybePerc = 1;

		/* Lavoro sporco end */
		
	break;
	
	case "edits.html":

		/* Edits start */

		var dataSetUrl = "../data/edits.php";

		var hashName = {
			"edit-totali": "0",
			"edit-minori": "1",
			"edit-revertati": "2",
			"edit-utenti-registrati": "3",
			"edit-anonimi": "4",
			"edit-bot": "5"
		};

		var maybeLink = 0;
		
		var colors = colors10;
		
		var maybePerc = 0;
		
		/* Edits end */
		
	break;
		
	case "lengths.html":

		/* Lengths start */

		var dataSetUrl = "../data/lengths.php";

		var hashName = {
			"0-750": "0",
			"750-1500": "1",
			"1500-3000": "2",
			"3000-6000": "3",
			"6000-12500": "4",
			"12500-25000": "5",
			"25000-50000": "6",
			"50000-75000": "7",
			"75000-100000": "8",
			"100000-125000": "9",
			"125000-infinito": "10"
		};

		var maybeLink = 0;
		
		var colors = colors10;
		
		var maybePerc = 0;
		
		/* Lengths end */
		
	break;
		
	case "pages.html":

		/* Pages start */

		var dataSetUrl = "../data/pages.php";

		var hashName = {
			"principale": "0",
			"discussione": "1",
			"utente": "2",
			"discussione-utente": "3",
			"wikipedia": "4",
			"discussione-wikipedia": "5",
			"file": "6",
			"discussione-file": "7",
			"mediawiki": "8",
			"discussione-mediawiki": "9",
			"template": "10",
			"discussione-template": "11",
			"aiuto": "12",
			"discussione-aiuto": "13",
			"categoria": "14",
			"discussione-categoria": "15",
			"portale": "16",
			"discussione-portale": "17",
			"progetto": "18",
			"discussione-progetto": "19",
			"modulo": "20",
			"discussione-modulo": "21"
		};

		var maybeLink = 0;
		
		var colors = colors24;
		
		var maybePerc = 0;
		
		/* Pages end */
		
	break;
		
	case "utils.html":

		/* Utils start */

		var dataSetUrl = "../data/utils.php";

		var hashName = {
			"senza-interlink": "0",
			"redirect": "1",
			"disambigue": "2",
			"interprogetto": "3",
			"portale": "4"
		};

		var maybeLink = 0;
		
		var colors = colors10;
		
		var maybePerc = 0;
		
		/* Utils end */
		
	break;
	
	default:
        console.err("config: unknown dataSet type");
}