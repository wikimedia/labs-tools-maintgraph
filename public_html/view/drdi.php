<?php
/* Template inspired by http://tools.wmflabs.org/bene/rfddone/ */

$file = '../data/drdi.csv';

if (($handle = fopen($file, 'r')) !== FALSE) {

  while (($lineArray = fgetcsv($handle)) !== FALSE) {
    $lastLine = $lineArray;
  }
  fclose($handle);
  
  $drdi_f = (float) ((($lastLine[1]+$lastLine[2])/$lastLine[3])/($lastLine[4]/$lastLine[5]))*100;
  
  $drdi = sprintf("%.2f%%", $drdi_f);
  $update = date("d/m/Y", strtotime($lastLine[0]));
  
} else {
  $drdi = "NULL";
  $update = "N/A";
}

echo <<<END
<!DOCTYPE html>
<html lang="it">
<head>
	<title>DRDI</title>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/bootstrap-theme.min.css" rel="stylesheet">
        
	<style type="text/css">
        html {
            height: 100%;
        }
        .container {
            width: 97% !important;
        }
		body {
			font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
			color: #333333;
		}
		a {
			text-decoration: none;
		}
		a:hover {
			text-decoration: underline;
		}
		.main {
			position: absolute;
			top: 20%;
			width: 50%;
			left: 25%;
			text-align: center;
			font-size: 2em;
		}
		#open {
			display: block;
			font-size: 5em;
		}
        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 1rem;
            font-size: 10px;
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
        }
	</style>
</head>

<body>
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="https://tools.wmflabs.org/maintgraph">MaintGraph</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="lavoro_sporco.html">Grafici lavoro sporco</a>
                    </li>
                    <li class="active"><a href="drdi.php">DRDI</a>
                    </li>
                </ul>
                <p class="navbar-text pull-right">
                    <a href="https://github.com/wikimedia/labs-tools-maintgraph" class="navbar-link">GitHub</a>
                </p>
            </div>
        </div>
    </div>
    
	<p class="main">
    Il <a href="https://it.wikipedia.org/wiki/Wikipedia:Indice_di_imprecisione_dei_collegamenti">DRDI</a> attuale &egrave; <span id="open">$drdi</span> aggiornato al $update.
	</p>
        
    <footer>
        Except where otherwise noted, MaintGraph is distributed under the terms of the <a href="http://www.opensource.org/licenses/mit-license.html">MIT license</a>. Feel free to contact MaintGraph's maintainers for any question or suggestion at: maintgraph [dot] maintainers [at] tools [dot] wmflabs [dot] org
    </footer>
</body>
</html>
END;
?>