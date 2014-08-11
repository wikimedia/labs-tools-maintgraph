<?php
header('Content-type: application/json');
header('Cache-Control: no-cache');
$file = 'lavoro_sporco.csv';

if (($handle = fopen($file, 'r')) !== FALSE) {
    $i = 0;
    while (($lineArray = fgetcsv($handle)) !== FALSE) {
        for ($j = 0; $j < count($lineArray); $j++) {
            if ($i == 0) {
                if ($j > 0) {
                    $arr[$j - 1][0]['name'] = $lineArray[$j];
                }
            }
            else {
                if ($j > 0) {
                    $arr[$j - 1][1]['data'][$i - 1]['date'] = $lineArray[0];
                    $arr[$j - 1][1]['data'][$i - 1]['tot'] = $lineArray[$j];
                }
            }
        }

        $i++;
    }

    fclose($handle);
}

$file = 'diff.csv';

if (($handle = fopen($file, 'r')) !== FALSE) {
    fgetcsv($handle); // remove first line
    $i = 0;
    while (($lineArray = fgetcsv($handle)) !== FALSE) {
        $z = 0;
        for ($j = 0; $j < count($lineArray); $j++) {
            if ($j % 2) {
                $arr[$z][1]['data'][$i]['add'] = $lineArray[$j];
                $arr[$z][1]['data'][$i]['rem'] = $lineArray[$j + 1];
                $arr[$z][1]['data'][$i]['diff'] = (string)($lineArray[$j] - $lineArray[$j + 1]);
                $z++;
            }
        }

        $i++;
    }

    fclose($handle);
}

echo json_encode($arr);
?>