<?php
/* Template inspired by http://tools.wmflabs.org/bene/rfddone/ */

$file = '../data/drdi.csv';

if (($handle = fopen($file, 'r')) !== FALSE) {

  while (($lineArray = fgetcsv($handle)) !== FALSE) {
    $lastLine = $lineArray;
  }
  fclose($handle);
  
  $link_dis = str_replace(" ", "&nbsp;", number_format($lastLine[1]+$lastLine[2], 0, ',', ' '));
  $dis = str_replace(" ", "&nbsp;", number_format($lastLine[4], 0, ',', ' '));
  $link_voci = str_replace(" ", "&nbsp;", number_format($lastLine[3], 0, ',', ' '));
  $voci = str_replace(" ", "&nbsp;", number_format($lastLine[5], 0, ',', ' '));
  
  $drdi_f = (float) ((($lastLine[1]+$lastLine[2])/$lastLine[4])/($lastLine[3]/$lastLine[5]))*100;
  
  $drdi = sprintf("%.2f%%", $drdi_f);
  $update = date("d/m/Y", strtotime($lastLine[0]));
  
} else {
  $drdi = "NULL";
  $link_dis = "NULL";
  $dis = "NULL";
  $link_voci = "NULL";
  $voci = "NULL";
  $update = "N/A";
}

echo <<<END
<html lang="it">

<head>
    <title>DRDI</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="//tools-static.wmflabs.org/static/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">
        html {
            height: 100%;
        }
        body {
            position: relative;
            margin: 0;
            padding-bottom: 4rem;
            min-height: 100%;
            padding-top: 50px;
        }
        .container {
            width: 97% !important;
        }
        a {
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .main {
            vertical-align: middle;
            text-align: center;
            font-size: 2em;
        }
        .right {
            vertical-align: middle;
            text-align: center;
            font-size: 1.1em;
        }
        .left {
            vertical-align: middle;
            text-align: left;
        }
        #open {
            display: block;
            font-size: 4em;
        }
        section {
            display: inline-block;
            position: absolute;
            top: 20%;
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
        @media (max-width: 768px) {
            body {
                padding-top: 120%;
                !important
            }
        }
        .row-table.row-table-xs {
            display: table !important;
        }
        .row-table.row-table-xs > [class*="col-"] {
            float: none !important;
            display: table-cell !important;
        }
        @media (min-width: 768px) {
            .row-table {
                display: table !important;
            }
            .row-table > [class*="col-"] {
                float: none !important;
                display: table-cell !important;
            }
        }
    </style>

    <script src="//tools-static.wmflabs.org/static/jquery/2.1.0/jquery.min.js"></script>
    <script src="//tools-static.wmflabs.org/static/bootstrap/3.2.0/js/bootstrap.min.js"></script>

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
                    <li><a href="lavoro_sporco.html">Lavoro sporco</a></li>
                    <li><a href="edits.html">Modifiche</a></li>
                    <li><a href="lengths.html">Dimensioni voci</a></li>
                    <li><a href="pages.html">Numero pagine</a></li>
                    <li><a href="utils.html">Varie</a></li>
                    <li class="active"><a href="drdi.php">DRDI</a></li>
                </ul>
                <p class="navbar-text pull-right">
                    <a href="https://github.com/wikimedia/labs-tools-maintgraph" class="navbar-link">GitHub</a>
                </p>
            </div>
        </div>
    </div>
    <div class='container'>
        <section>
            <div class='row-table'>
                <div class='col-sm-3 left'>
                    <p>Lo studio sull'<b>imprecisione dei collegamenti</b> ci fornisce informazioni sui wikilink errati che puntano a disambigue anzich&eacute; a voci.</p>
                    <p>La percentuale tra i wikilink a disambigue sul totale dei wikilink a voci e il numero di disambigue sul totale delle voci &egrave; nota come <b>indice di imprecisione dei collegamenti</b> o <b>disambiguation rule disregard index</b> (DRDI).</p>
                </div>

                <div class='col-sm-1 main'>
                    Il <a href="https://it.wikipedia.org/wiki/Wikipedia:Indice_di_imprecisione_dei_collegamenti">DRDI</a> attuale &egrave; <span id="open">$drdi</span> aggiornato al $update

                </div>

                <div class='col-sm-3 right'>
                    <ul class="list-group">
                        <li class="list-group-item">
                            <span class="badge">$link_dis</span>
                            Wikilink a disambigue
                        </li>
                        <li class="list-group-item">
                            <span class="badge">$dis</span>
                            Numero di disambigue
                        </li>
                        <li class="list-group-item">
                            <span class="badge">$link_voci</span>
                            Wikilink a voci
                        </li>
                        <li class="list-group-item">
                            <span class="badge">$voci</span>
                            Numero di voci
                        </li>
                    </ul>

                </div>
            </div>
        </section>

    </div>

    <footer>
        Except where otherwise noted, MaintGraph is distributed under the terms of the <a href="http://www.opensource.org/licenses/mit-license.html">MIT license</a>. Feel free to contact MaintGraph's maintainers for any question or suggestion at: maintgraph [dot] maintainers [at] tools [dot] wmflabs [dot] org
    </footer>
</body>

</html>
END;
?>